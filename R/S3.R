#' Convert JSON-stat object into JSON-stat JSON string
#'
#' @param x JSON-stat object
#' @return JSON output
#' @export
as.jsonstat <- function(x) {
  UseMethod("as.jsonstat")
}

#verify <- function(x, ...) {
#  UseMethod("verify")
#}

#' Create dimension object
#'
#' @param .plan \code{jsonstat.compress.plan} object
#' @param dim_name name of dimension
#' @param role_name role of dimension
#' @param label label of dimension
#' @return \code{jsonstat.compress.plan} object
#' @export
dimension <- function(.plan, dim_name, role_name, label) {
  UseMethod("dimension")
}

