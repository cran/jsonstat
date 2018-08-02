context("galicia")

test_that("galicia", {
  .path <- file.path("input", "galicia.csv")
  expect_true(file.exists(.path))

  x <- read.csv2(.path, sep = ",")

  .plan <- compress_plan("place.of.birth", "geo", "Place of Birth") %>%
    dimension("age.group", "classification", "Age Group") %>%
    dimension("gender", "classification", "Gender") %>%
    dimension("year", "time", "Year") %>%
    dimension("province.of.residence", "geo", "Province of Residence") %>%
    dimension("concept", "metric", "Concept") %>%
    dimension("value", "value", "value")

  res <- compress(x, .plan)
  expect_true(inherits(res, "jsonstat.data"))

  .extension <- list(id = 3,
                     name = "asdfdsfsd",
                     lol = TRUE,
                     arr = 1:5,
                     training = list(name = "training",
                                     from = "xxxx",
                                     to = "yyyy"),
                     testing = list(name = "testing",
                                    from = "xxxx",
                                    to = "yyyy"))

  .dataset <- as.dataset(x, .plan,
                label = paste("Population by province of residence,",
                              "place of birth, age, gender and year",
                              "in Galicia"),
                href = "https://github.com/zedoul/jsonstat",
                extension = .extension)
  expect_true(inherits(.dataset, "jsonstat.dataset"))

  .jsonstat <- as.jsonstat(.dataset)
  expect_true(inherits(.jsonstat, "json"))

  .collection <- as.collection(.dataset, label = "Comparison",
                               href = "https://github.com/zedoul/jsonstat")
  expect_true(inherits(.collection, "jsonstat.collection"))

  .jsonstat <- as.jsonstat(.collection)
  expect_true(inherits(.jsonstat, "json"))
})

