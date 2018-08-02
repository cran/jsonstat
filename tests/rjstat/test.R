library(rjstat)

.path <- file.path("tests", "testthat", "input", "galicia.csv")
expect_true(file.exists(.path))

iris <- read.csv2(.path, sep = ",")
irisJSONstat <- toJSONstat(list(iris=iris))
print(irisJSONstat)
