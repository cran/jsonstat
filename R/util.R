#' @importFrom cli cat_rule
rule <- function(...) cli::cat_rule(..., col = "green")

rng <- function(from, to) {
  from <- as.integer(from)
  to <- as.integer(to)

  if (from > to) {
    NULL
  } else {
    seq(from, to)
  }
}

autounbox <- function(.list) {
  stopifnot(inherits(.list, "list"))
  stopifnot(!is.null(names(.list)))

  for (.name in names(.list)) {
    v <- .list[[.name]]

    if (inherits(v, "list")) {
       .list[[.name]] <- autounbox(.list[[.name]])
    } else if (any(class(v) %in% c("integer",
                                   "numeric",
                                   "character",
                                   "logical"))) {
      if (length(v) == 1) {
        .list[[.name]] <- jsonlite::unbox(v)
      }
    } else {
      stop("Unexpected value")
    }
  }

  .list
}
