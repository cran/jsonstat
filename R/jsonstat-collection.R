#' Convert data set into JSON-stat collection
#'
#' @param ... a named list, the function creates a collection
#'   based on user input like the same way as `list`.
#' @param label label of dataset
#' @param href href of dataset, "" by default
#' @param src source of dataset, NULL by default
#' @param extension user data, NULL by default
#' @importFrom rlang enquos
#' @export
as.collection <- function(...,
                          label = "",
                          href = "",
                          src = NULL,
                          extension = NULL) {
  version = "2.0"
  updated = as.character(Sys.time())

  v <- list()
  v$version <- jsonlite::unbox(version)
  v$class <- jsonlite::unbox("collection")
  v$label <- jsonlite::unbox(label)
  v$href <- jsonlite::unbox(href)
  v$updated <- jsonlite::unbox(updated)
  if (!is.null(src)) {
    v$source <- autounbox(src)
  }
  if (!is.null(extension)) {
    v$extension <- autounbox(extension)
  }

  .dots <- list(...)
  for (.name in names(.dots)) {
    stopifnot(inherits(.dots[[.name]], "jsonstat.dataset"))
  }
  v$link$item <- unname(.dots)

  structure(v, class = c("jsonstat.collection", "list"))
}

#verify.jsonstat.collection <- function(.collection) {
#  warning("not implemented yet")
#}
