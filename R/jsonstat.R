#' jsonstat: R package for JSON-stat
#'
#' jsonstat provides useful functions to work with JSON-stat format.
#' @docType package
#' @name jsonstat
"_PACKAGE"

#' Convert JSON-stat collection into JSON
#'
#' @param x JSON-stat collection
#' @param auto_unbox this flag marks atomic vectors in given list as a
#'   singleton, so it will not turn into an 'array' when encoded into JSON.
#'   FALSE by default.
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
#' .jsonstat <- toJSON(.collection)
toJSON.jsonstat.collection <- function(x, auto_unbox = F) {
  jsonlite::toJSON(x, auto_unbox = auto_unbox)
}

#' Convert JSON-stat dataset into JSON
#'
#' @param x JSON-stat dataset
#' @param auto_unbox this flag marks atomic vectors in given list as a
#'   singleton, so it will not turn into an 'array' when encoded into JSON.
#'   FALSE by default.
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
#' .jsonstat <- toJSON(.dataset)
toJSON.jsonstat.dataset <- function(x, auto_unbox = F) {
  jsonlite::toJSON(x, auto_unbox = auto_unbox)
}

if(getRversion() >= "2.15.1")  utils::globalVariables(c("role"))
