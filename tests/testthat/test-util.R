context("util")

test_that("autounbox", {
  .list <- list(a = 3, b = 4)
  .list <- autounbox(.list)
  expect_true(inherits(.list$a, "scalar"))
  expect_true(inherits(.list$b, "scalar"))

  .list <- list(3, 4)
  expect_error(autounbox(.list), NA)

  .list <- list(a = galicia)
  expect_error(autounbox(.list), NA)

  .list <- list(a = T)
  .list <- autounbox(.list)
  expect_true(inherits(.list$a, "scalar"))
  expect_true(inherits(.list$a, "logical"))

  .list <- list(a = 3,
                b = list(a = 4,
                         b = list(a = 1)))
  .list <- autounbox(.list)
  expect_true(inherits(.list$b$b$a, "scalar"))

  .list <- list(3,
                list(4,
                     list(a = 1)))
  .list <- autounbox(.list)
    expect_true(inherits(.list[[2]][[2]][[1]], "scalar"))


  .list <- list(a = 3, b = NULL)
  .list <- autounbox(.list)

  .list <- list(a = 3, b = NULL)
  .list <- autounbox(.list)
})

