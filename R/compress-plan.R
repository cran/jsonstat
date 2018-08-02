#' compress plan
#'
#' This function constructs a plan to compress data frame into jsonstat
#'
#' @param dim_name name of dimension
#' @param role_name role of dimension
#' @param label label of dimension
#' @return \code{jsonstat.compress.plan} object
#' @export
#' @examples
#' library(jsonstat)
#'
#' .plan <- compress_plan("place.of.birth", "geo", "Place of Birth")
compress_plan <- function(dim_name,
                          role_name = c("time", "geo", "metric",
                                        "classification", "value"),
                          label = NULL) {
  # TODO: Support category attribute
  .df <- data.frame(dimension = character(),
                    role = character(), stringsAsFactors = F)
  v <- structure(list(plan = .df,
                      category = list()),
                 class = "jsonstat.compress.plan")
  dimension(v, dim_name, role_name, label)
}

#' dimension
#'
#' This function adds another dimension into compress plan
#'
#' @param .plan \code{jsonstat.compress.plan} object
#' @param dim_name name of dimension
#' @param role_name role of dimension
#' @param label label of dimension
#' @return \code{jsonstat.compress.plan} object
#' @export
#' @examples
#' library(jsonstat)
#'
#' .plan <- compress_plan("place.of.birth", "geo", "Place of Birth")
#' .plan <- dimension(.plan, "age.group", "classification", "Age Group")
dimension.jsonstat.compress.plan <- function(.plan,
                                             dim_name,
                                             role_name = c("time", "geo",
                                                           "metric",
                                                           "classification",
                                                           "value"),
                                             label = NULL) {
  stopifnot(role_name %in%
            c("time", "geo", "metric", "classification", "value"))
  if (is.null(label)) {
    label <- dim_name
  }

  .df <- data.frame(dimension = dim_name,
                    role = role_name,
                    label = label, stringsAsFactors = F)

  .plan$plan <- rbind(.plan$plan, .df)
  .plan$category[[dim_name]] <- list()
  stopifnot(nrow(.plan$df) == length(.plan$category))

  .plan
}

#verify.jsonstat.compress.plan <- function(.plan) {
#  if (sum("value" == .plan$plan$role) != 1) {
#    stop('compress plan needs one "value" role')
#  }
#}

print.jsonstat.compress.plan <- function(.plan) {
  rule("plan")
  print(.plan$plan)
}

