#' jsonstat: R package for JSON-stat
#'
#' jsonstat provides useful functions to work with JSON-stat format.
#' @docType package
#' @name jsonstat
"_PACKAGE"

#' Convert JSON-stat collection into JSON
#'
#' @param x JSON-stat collection
#' @return JSON output
#' @export
#' @examples
#' library(jsonstat)
#' library(dplyr)
#'
#' .plan <- compress_plan("place.of.birth", "geo", "Place of Birth") %>%
#'   dimension("age.group", "classification", "Age Group") %>%
#'   dimension("gender", "classification", "Gender") %>%
#'   dimension("year", "time", "Year") %>%
#'   dimension("province.of.residence", "geo", "Province of Residence") %>%
#'   dimension("concept", "metric", "Concept") %>%
#'   dimension("value", "value", "value")
#'
#' .dataset <- as.dataset(galicia, .plan,
#'               label = paste("Population by province of residence,",
#'                             "place of birth, age, gender and year",
#'                             "in Galicia"),
#'               href = "https://github.com/zedoul/jsonstat")
#'
#' .collection <- as.collection(.dataset, label = "Comparison",
#'                              href = "https://github.com/zedoul/jsonstat")
#'
#' .jsonstat <- as.jsonstat(.collection)
as.jsonstat.jsonstat.collection <- function(x) {
  jsonlite::toJSON(x, auto_unbox = F)
}

#' Convert JSON-stat dataset into JSON
#'
#' @param x JSON-stat dataset
#' @return JSON output
#' @importFrom jsonlite toJSON
#' @export
#' @examples
#' library(jsonstat)
#' library(dplyr)
#'
#' .plan <- compress_plan("place.of.birth", "geo", "Place of Birth") %>%
#'   dimension("age.group", "classification", "Age Group") %>%
#'   dimension("gender", "classification", "Gender") %>%
#'   dimension("year", "time", "Year") %>%
#'   dimension("province.of.residence", "geo", "Province of Residence") %>%
#'   dimension("concept", "metric", "Concept") %>%
#'   dimension("value", "value", "value")
#'
#' .dataset <- as.dataset(galicia, .plan,
#'               label = paste("Population by province of residence,",
#'                             "place of birth, age, gender and year",
#'                             "in Galicia"),
#'               href = "https://github.com/zedoul/jsonstat")
#'
#' .jsonstat <- as.jsonstat(.dataset)
as.jsonstat.jsonstat.dataset <- function(x) {
  jsonlite::toJSON(x, auto_unbox = T)
}

if(getRversion() >= "2.15.1")  utils::globalVariables(c("role"))
