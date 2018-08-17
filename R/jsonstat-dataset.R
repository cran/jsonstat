#' Convert data frame into JSON-stat dataset
#'
#' @param x data frame
#' @param .plan compress plan
#' @param label label of dataset
#' @param href href of dataset, "" by default
#' @param src source of dataset, NULL by default
#' @param extension user data, NULL by default
#' @param updated a timestamp for data, NULL by default
#' @importFrom jsonlite unbox
#' @export
as.dataset <- function(x,
                       .plan,
                       label,
                       href = "",
                       src = NULL,
                       extension = NULL,
                       updated = NULL) {
  stopifnot(inherits(x, "data.frame"))
  stopifnot(inherits(.plan, "jsonstat.compress.plan"))

  version = "2.0"
  if (is.null(updated)) {
    updated = as.character(Sys.time())
  }
  stopifnot(inherits(updated, "character"))

  v <- c(version = version,
         class = "dataset",
         label = label,
         href = href,
         updated = updated,
         compress(x, .plan))
  v$version <- jsonlite::unbox(v$version)
  v$class <- jsonlite::unbox(v$class)
  v$label <- jsonlite::unbox(v$label)
  v$href <- jsonlite::unbox(v$href)
  v$updated <- jsonlite::unbox(v$updated)
  if (!is.null(src)) {
    v$source <- autounbox(src)
  }
  if (!is.null(extension)) {
    v$extension <- autounbox(extension)
  }

  structure(v, class = c("jsonstat.dataset", "list"))
}

#verify.jsonstat.dataset <- function(.dataset) {
#  warning("not implemented yet")
#}
