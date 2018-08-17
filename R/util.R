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

#' Unbox list object
#'
#' This function marks atomic vectors in given list as a singleton, so that it
#' will not turn into an 'array' when encoded into JSON.
#'
#' @param .list a list contains atomic vectors
#' @importFrom jsonlite unbox
#' @export
autounbox <- function(.list) {
  stopifnot(inherits(.list, "list"))

  for (.name in rng(1, length(.list))) {
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
    } else if (inherits(v, "data.frame")) {
      next
    } else if (is.null(v)) {
      next
    } else {
      stop("Unexpected value: ", .name, class(v))
    }
  }

  .list
}
