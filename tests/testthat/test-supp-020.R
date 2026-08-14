# tests/testthat/test-regression-020.R

library(testthat)

# ============================================================================
# TESTS DE RÉGRESSION SPÉCIFIQUES À LA VERSION 0.2.0
# ============================================================================

test_that("Regression with multiplicity works", {
  skip_if_not_installed("BsplineQuantReg")

  data <- create_test_data(n = 50)
  knots <- c(0, 0.25, 0.5, 0.75, 1)
  multiplicities <- c(4, 1, 3, 1, 4)  # degree=3 => degree+1=4 aux extrémités

  knot_seq <- build_knot_sequence(knots, multiplicities)

  # Vérifier que la séquence est correcte
  expected <- c(0, 0, 0, 0, 0.25, 0.5, 0.5, 0.5, 0.75, 1, 1, 1, 1)
  expect_equal(knot_seq, expected)

  # Vérifier que la régression fonctionne avec la séquence étendue
  kn <- length(knots) - 1

  expect_silent({
    fit <- BsplineQuantReg::quantile_spline(
      x = data$x,
      y = data$y,
      knot = knot_seq,
      tau = 0.5,
      degree = 3,
      monot = rep(0, kn + 1),
      convcons = rep(0, kn + 1),
      der3cons = rep(0, kn + 1),
      callable = TRUE
    )
  })
})

test_that("Regression with different knot multiplicities", {
  skip_if_not_installed("BsplineQuantReg")

  data <- create_test_data(n = 50)

  # Test avec différentes multiplicités
  test_cases <- list(
    list(knots = c(0, 0.3, 0.7, 1), mult = c(4, 1, 1, 4)),
    list(knots = c(0, 0.3, 0.7, 1), mult = c(4, 2, 1, 4)),
    list(knots = c(0, 0.3, 0.7, 1), mult = c(4, 1, 2, 4))
  )

  for (tc in test_cases) {
    knot_seq <- build_knot_sequence(tc$knots, tc$mult)
    kn <- length(tc$knots) - 1

    expect_silent({
      fit <- BsplineQuantReg::quantile_spline(
        x = data$x,
        y = data$y,
        knot = knot_seq,
        tau = 0.5,
        degree = 3,
        monot = rep(0, kn + 1),
        convcons = rep(0, kn + 1),
        der3cons = rep(0, kn + 1),
        callable = TRUE
      )
    })
  }
})

test_that("Code generation includes multiplicity", {
  # Vérifier que le code généré inclut les multiplicités
  knots <- c(0, 0.25, 0.5, 0.75, 1)
  multiplicities <- c(4, 1, 1, 1, 4)
  knot_seq <- build_knot_sequence(knots, multiplicities)

  code <- sprintf(
    "knot <- c(%s)",
    paste(round(knot_seq, 4), collapse = ", ")
  )

  expect_true(grepl("0, 0, 0, 0", code))
  expect_true(grepl("1, 1, 1, 1", code))
})
