context("compress_plan")

test_that("compress_plan", {
  .plan <- compress_plan("A", "time", "AAA") %>%
    dimension("B", "metric", "BBB") %>%
    dimension("K", "metric", "KKK") %>%
    dimension("value", "value", "value")

  expect_true(inherits(.plan, "jsonstat.compress.plan"))
})

