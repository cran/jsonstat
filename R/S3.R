#' Convert JSON-stat object into JSON-stat JSON string
#'
#' @param x JSON-stat object
#' @param auto_unbox this flag marks atomic vectors in given list as a
#'   singleton, so it will not turn into an 'array' when encoded into JSON.
#'   FALSE by default.
#' @return JSON output
#' @export
toJSON <- function(x, auto_unbox) {
  UseMethod("toJSON")
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

