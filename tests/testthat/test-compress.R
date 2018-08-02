context("compress")

test_that("compress/as.dataset/as.collection", {
  # needs to be tidy data
  x <- data.frame(A = c(1, 2, 3, 1),
                  B = c("A", "B", "C", "C"),
                  K = c("kk", "hh", "hh", "hh"),
                  value = c(12, 43, 55, 1))

  .plan <- compress_plan("A", "time", "AAA") %>%
    dimension("B", "metric", "BBB") %>%
    dimension("K", "metric", "KKK") %>%
    dimension("value", "value", "value")

  res <- compress(x, .plan)
  expect_true(inherits(res, "jsonstat.data"))

  .dataset <- as.dataset(x, .plan, label = "jsonstat result",
                         href = "https://raw.githubusercontent.com/zedoul/jsonstat/master/tests/testthat/output/galicia_jsonstat.json")
  expect_true(inherits(.dataset, "jsonstat.dataset"))

  .jsonstat <- as.jsonstat(.dataset)
  expect_true(inherits(.jsonstat, "json"))

  .dataset2 <- as.dataset(x, .plan, label = "rjstat result",
                         href = "https://raw.githubusercontent.com/zedoul/jsonstat/master/tests/testthat/output/galicia_rjstat.json")
  expect_true(inherits(.dataset, "jsonstat.dataset"))

  .collection <- as.collection(.dataset, .dataset2, label = "Comparison",
                               href = "https://github.com/zedoul/jsonstat")
  expect_true(inherits(.collection, "jsonstat.collection"))

  .jsonstat <- as.jsonstat(.collection)
  expect_true(inherits(.jsonstat, "json"))
})

