#' @importFrom dplyr filter
#' @importFrom jsonlite unbox
compress <- function(x, .plan) {
  if (is.null(x)) {
    return(NULL)
  }
  stopifnot(inherits(.plan, "jsonstat.compress.plan"))

  value <- dplyr::filter(.plan$plan, role == "value")$dimension
  stopifnot(length(value) == 1)

  i <- vapply(x, is.raw, logical(1))
  x[i] <- lapply(x[i], as.character)

  dimensions <- x[names(x) != value]
  j <- !vapply(dimensions, is.factor, logical(1))
  dimensions[j] <- lapply(dimensions[j], factor)

  dimension_sizes <- vapply(dimensions, nlevels, integer(1))
  dimension_ids <- names(dimensions)

  # Construct role attribute
  roles <- list(time = c(),
                geo = c(),
                metric = c(),
                classification = c())
  for (i in rng(1, nrow(.plan$plan))) {
    if (.plan$plan[i, "role"] %in%
          c("time", "geo", "metric", "classification")) {
      roles[[.plan$plan[i, "role"]]] <- c(roles[[.plan$plan[i, "role"]]],
                                          .plan$plan[i, "dimension"])
    }
  }

  for (.name in names(roles)) {
    if (is.null(roles[[.name]])) {
      roles[[.name]] <- ""
    }
  }

  dimension_roles <- roles

  # Construct categories
  categories <- list()
  for (i in rng(1, ncol(dimensions))) {
    .name <- colnames(dimensions)[i]
    .label <- dplyr::filter(.plan$plan, dimension == .name)$label
    v <- dimensions[, i]
    .category <- list(index = levels(v))
    categories[[.name]] <- list(label = unbox(.label),
                                category = .category)
  }

  dim_factors <- c(rev(cumprod(rev(dimension_sizes)))[-1], 1)

  sort_table <- lapply(dimensions, function(dimension) {
      unclass(dimension) - 1
  })
  sort_table <- Map(`*`, sort_table, dim_factors)

  sort_index <- Reduce(`+`, sort_table) + 1

  if (any(duplicated(sort_index))) {
      stop("non-value columns must constitute a unique ID", call. = FALSE)
  }

  n <- prod(dimension_sizes)
  values <- x[[value]]
  if (length(values) == n) {
      values[sort_index] <- values
  } else {
      values <- lapply(values, unbox)
      names(values) <- sort_index - 1
  }

  .data <- list(id = dimension_ids,
                size = dimension_sizes,
                role = dimension_roles,
                value = values,
                dimension = categories)

  structure(.data, class = c("jsonstat.data", "list"))
}

