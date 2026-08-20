# tests/run_all_tests.R
# Run this from the package root directory

run_all_tests <- function() {
  cat("\n")
  cat("╔══════════════════════════════════════════════════════════════╗\n")
  cat("║     BsplineQuantReg GUI - Complete Test Suite              ║\n")
  cat("╚══════════════════════════════════════════════════════════════╝\n")
  cat("\n")
source("tests/testthat/test-common.R")
source("tests/testthat/test-advanced-features.R")
source("tests/testthat/test-basic-features.R")
#source("tests/testthat/test-basic-features.R")
  }

# Run all tests
if (interactive()) {
  run_all_tests()
}
