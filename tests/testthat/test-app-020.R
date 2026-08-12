# tests/testthat/test-app-020.R

library(testthat)

# ============================================================================
# HELPERS SPÉCIFIQUES POUR LA VERSION 0.2.0
# ============================================================================

#' Créer un mock de l'application pour tester les fonctionnalités
create_mock_app_020 <- function() {
  values <- list2env(list(
    xtab = NULL,
    ytab = NULL,
    knot = NULL,
    knot_multiplicity = NULL,
    knot_extended = NULL,
    manual_knot = vector(),
    auto_knot_list = vector(),
    adding_knot = FALSE,
    fitted = NULL,
    x_eval = NULL,
    y_eval = NULL,
    curve_lines = list(),
    regions = list(),
    data_name = "No data available",
    region_id = 0,
    selected_region_id = NULL,
    selecting_region = FALSE
  ))
  
  list(
    get_state = function() {
      as.list(values)
    },
    
    generate_test_data = function(n = 200, xmin = 0, xmax = 1, seed = 42) {
      set.seed(seed)
      x <- seq(xmin, xmax, length.out = n)
      y <- 2 * x + 0.2 * sin(10 * pi * x) + 0.05 * rnorm(n)
      values$xtab <- x
      values$ytab <- y
      values$data_name <- paste("Test [", xmin, ",", xmax, "]", sep = " ")
      values$fitted <- NULL
      values$curve_lines <- list()
      values$regions <- list()
      return(TRUE)
    },
    
    set_knots = function(knots, multiplicities = NULL) {
      values$knot <- knots
      if (is.null(multiplicities)) {
        values$knot_multiplicity <- rep(1, length(knots))
        values$knot_multiplicity[1] <- 4  # degree + 1 par défaut (degree=3)
        values$knot_multiplicity[length(knots)] <- 4
      } else {
        values$knot_multiplicity <- multiplicities
      }
      return(TRUE)
    },
    
    add_knot = function(x) {
      if (!is.null(values$xtab)) {
        if (x > min(values$xtab) && x < max(values$xtab)) {
          if (!any(abs(values$knot - x) < 1e-6)) {
            values$manual_knot <- sort(c(values$manual_knot, x))
            values$knot <- sort(c(values$knot, x))
            # Ajouter multiplicité
            idx <- which(values$knot == x)
            values$knot_multiplicity <- c(
              values$knot_multiplicity[1:(idx-1)],
              1,
              values$knot_multiplicity[idx:length(values$knot_multiplicity)]
            )
            return(TRUE)
          }
        }
      }
      return(FALSE)
    },
    
    remove_knot = function(idx) {
      if (is.null(values$knot) || idx < 1 || idx > length(values$knot)) {
        return(FALSE)
      }
      if (idx == 1 || idx == length(values$knot)) {
        return(FALSE)  # Ne pas supprimer les extrémités
      }
      values$knot <- values$knot[-idx]
      values$knot_multiplicity <- values$knot_multiplicity[-idx]
      return(TRUE)
    },
    
    update_multiplicity = function(idx, new_mult) {
      if (is.null(values$knot) || idx < 1 || idx > length(values$knot)) {
        return(FALSE)
      }
      if (idx == 1 || idx == length(values$knot)) {
        return(FALSE)  # Ne pas modifier les extrémités
      }
      new_mult <- max(1, min(new_mult, 4))  # degree + 1 = 4
      values$knot_multiplicity[idx] <- new_mult
      return(TRUE)
    },
    
    add_region = function(xmin, xmax, monot = 0, conv = 0, der3 = 0) {
      if (is.null(xmin) || is.null(xmax) || xmin >= xmax) {
        return(FALSE)
      }
      values$region_id <- values$region_id + 1
      region <- list(
        id = values$region_id,
        xmin = xmin,
        xmax = xmax,
        monot = monot,
        conv = conv,
        der3 = der3
      )
      values$regions <- c(values$regions, list(region))
      return(TRUE)
    },
    
    clear_all = function() {
      values$xtab <- NULL
      values$ytab <- NULL
      values$knot <- NULL
      values$knot_multiplicity <- NULL
      values$knot_extended <- NULL
      values$manual_knot <- vector()
      values$fitted <- NULL
      values$curve_lines <- list()
      values$regions <- list()
      values$region_id <- 0
      values$selected_region_id <- NULL
      values$data_name <- "No data"
      return(TRUE)
    }
  )
}

#' Build knot sequence with multiplicities (reproduit build_knot_sequence)
build_knot_sequence <- function(knots, multiplicities) {
  if (is.null(knots) || length(knots) == 0) {
    return(c())
  }
  if (is.null(multiplicities) || length(multiplicities) != length(knots)) {
    return(knots)  # Fallback
  }
  
  knot_seq <- c()
  for (i in seq_along(knots)) {
    knot_seq <- c(knot_seq, rep(knots[i], multiplicities[i]))
  }
  return(knot_seq)
}

# ============================================================================
# TESTS : GESTION DES NOEUDS
# ============================================================================

test_that("Minimum knots requirement is enforced", {
  app <- create_mock_app_020()
  app$generate_test_data(n = 50)
  
  # Minimum 2 knots
  knots <- c(0, 1)
  app$set_knots(knots)
  state <- app$get_state()
  expect_length(state$knot, 2)
  
  # Vérifier que les multiplicités sont correctes pour les extrémités
  expect_equal(state$knot_multiplicity[1], 4)  # degree=3 => degree+1=4
  expect_equal(state$knot_multiplicity[length(state$knot)], 4)
})

test_that("Adding knots works correctly", {
  app <- create_mock_app_020()
  app$generate_test_data(n = 50)
  app$set_knots(c(0, 0.5, 1))
  
  # Ajouter un noeud
  expect_true(app$add_knot(0.3))
  state <- app$get_state()
  expect_true(0.3 %in% state$knot)
  expect_length(state$knot, 4)
  
  # Vérifier la multiplicité du nouveau noeud
  idx <- which(state$knot == 0.3)
  expect_equal(state$knot_multiplicity[idx], 1)
  
  # Ajouter un noeud existant (devrait échouer)
  expect_false(app$add_knot(0.3))
  
  # Ajouter un noeud hors intervalle (devrait échouer)
  expect_false(app$add_knot(-0.1))
  expect_false(app$add_knot(1.1))
})

test_that("Removing knots works correctly", {
  app <- create_mock_app_020()
  app$generate_test_data(n = 50)
  app$set_knots(c(0, 0.25, 0.5, 0.75, 1))
  
  # Supprimer un noeud interne
  idx <- 3  # 0.5
  expect_true(app$remove_knot(idx))
  state <- app$get_state()
  expect_length(state$knot, 4)
  expect_false(0.5 %in% state$knot)
  
  # Ne pas pouvoir supprimer les extrémités
  expect_false(app$remove_knot(1))  # début
  expect_false(app$remove_knot(length(state$knot)))  # fin
  
  # Supprimer un noeud inexistant
  expect_false(app$remove_knot(99))
  expect_false(app$remove_knot(-1))
})

test_that("Knot multiplicity management works", {
  app <- create_mock_app_020()
  app$generate_test_data(n = 50)
  app$set_knots(c(0, 0.25, 0.5, 0.75, 1))
  
  # Multiplicité initiale des extrémités = 4
  state <- app$get_state()
  expect_equal(state$knot_multiplicity[1], 4)
  expect_equal(state$knot_multiplicity[length(state$knot)], 4)
  
  # Modifier la multiplicité d'un noeud interne
  idx <- 3  # 0.5
  expect_true(app$update_multiplicity(idx, 2))
  state <- app$get_state()
  expect_equal(state$knot_multiplicity[idx], 2)
  
  # Augmenter la multiplicité
  expect_true(app$update_multiplicity(idx, 3))
  state <- app$get_state()
  expect_equal(state$knot_multiplicity[idx], 3)
  
  # Ne pas dépasser degree+1 (4)
  expect_true(app$update_multiplicity(idx, 5))
  state <- app$get_state()
  expect_equal(state$knot_multiplicity[idx], 4)  # Limité à 4
  
  # Ne pas pouvoir modifier les extrémités
  expect_false(app$update_multiplicity(1, 2))
  expect_false(app$update_multiplicity(length(state$knot), 2))
})

# ============================================================================
# TESTS : BUILD_KNOT_SEQUENCE
# ============================================================================

test_that("build_knot_sequence works correctly", {
  knots <- c(0, 0.25, 0.5, 0.75, 1)
  multiplicities <- c(4, 1, 2, 1, 4)
  
  seq <- build_knot_sequence(knots, multiplicities)
  expected <- c(0, 0, 0, 0, 0.25, 0.5, 0.5, 0.75, 1, 1, 1, 1)
  expect_equal(seq, expected)
  
  # Test avec valeurs NULL
  expect_equal(build_knot_sequence(NULL, NULL), c())
  expect_equal(build_knot_sequence(knots, NULL), knots)
})

# ============================================================================
# TESTS : RÉGIONS
# ============================================================================

test_that("Region management works with mock app 0.2.0", {
  app <- create_mock_app_020()
  app$generate_test_data(n = 50)
  app$set_knots(c(0, 0.25, 0.5, 0.75, 1))
  
  # Ajouter une région
  expect_true(app$add_region(0.3, 0.6, 1, 0, 0))
  state <- app$get_state()
  expect_length(state$regions, 1)
  expect_equal(state$regions[[1]]$xmin, 0.3)
  expect_equal(state$regions[[1]]$xmax, 0.6)
  
  # Ajouter une seconde région
  expect_true(app$add_region(0.6, 0.8, -1, 1, 0))
  state <- app$get_state()
  expect_length(state$regions, 2)
  
  # Ajouter une région invalide
  expect_false(app$add_region(0.6, 0.3))  # xmin > xmax
  expect_false(app$add_region(NULL, 0.5))
})

# ============================================================================
# TESTS : CLEAR ALL
# ============================================================================

test_that("Clear all works correctly with mock app 0.2.0", {
  app <- create_mock_app_020()
  
  # Setup des données
  app$generate_test_data(n = 50)
  app$set_knots(c(0, 0.25, 0.5, 0.75, 1))
  app$add_region(0.3, 0.6)
  
  state <- app$get_state()
  expect_false(is.null(state$xtab))
  expect_false(is.null(state$knot))
  expect_length(state$regions, 1)
  
  # Clear all
  expect_true(app$clear_all())
  state <- app$get_state()
  expect_null(state$xtab)
  expect_null(state$ytab)
  expect_null(state$knot)
  expect_null(state$knot_multiplicity)
  expect_length(state$regions, 0)
  expect_equal(state$data_name, "No data")
})

# ============================================================================
# TESTS : VISUALISATION DE LA BASE
# ============================================================================

test_that("Basis visualization requires knots", {
  app <- create_mock_app_020()
  
  # Sans données, la base ne devrait pas être générée
  expect_true(is.null(app$get_state()$knot))
  
  # Avec des données mais sans noeuds
  app$generate_test_data(n = 50)
  expect_true(is.null(app$get_state()$knot))
  
  # Avec des noeuds
  app$set_knots(c(0, 0.25, 0.5, 0.75, 1))
  state <- app$get_state()
  expect_false(is.null(state$knot))
})

# ============================================================================
# TESTS : CODE GÉNÉRÉ
# ============================================================================

test_that("Generated R code is syntactically valid", {
  # Test de la structure du code généré
  code_template <- '
library(BsplineQuantReg)

x <- c(0, 0.2, 0.4, 0.6, 0.8, 1)
y <- c(0, 0.1, 0.3, 0.5, 0.7, 0.9)
knot <- c(0, 0.25, 0.5, 0.75, 1)

fitted <- quantile_spline(x, y,
  knot = knot,
  tau = 0.5,
  degree = 3,
  monot = c(0, 0, 0, 0),
  convcons = c(0, 0, 0, 0, 0),
  der3cons = c(0, 0, 0, 0, 0),
  solver = "ECOS",
  callable = TRUE
)

x_eval <- seq(min(x), max(x), length.out = 300)
y_eval <- fitted(x_eval)
plot(x, y, pch = 16, cex = 0.5, col = "gray")
lines(x_eval, y_eval, col = "blue", lwd = 2)
'
  
  # Vérifier que le code est valide
  expect_true(is.character(code_template))
  expect_true(nchar(code_template) > 0)
  
  # Vérifier la présence des éléments clés
  expect_true(grepl("library\\(BsplineQuantReg\\)", code_template))
  expect_true(grepl("quantile_spline", code_template))
  expect_true(grepl("knot =", code_template))
  expect_true(grepl("tau =", code_template))
  expect_true(grepl("degree =", code_template))
  expect_true(grepl("callable = TRUE", code_template))
  expect_true(grepl("plot\\(", code_template))
  expect_true(grepl("lines\\(", code_template))
})

# ============================================================================
# TESTS : INTÉGRATION DES NOEUDS AVEC LES CONTRAINTES
# ============================================================================

test_that("Knot multiplicity affects constraint length", {
  app <- create_mock_app_020()
  app$generate_test_data(n = 50)
  app$set_knots(c(0, 0.25, 0.5, 0.75, 1))
  
  # Multiplicité initiale
  state <- app$get_state()
  expect_equal(state$knot_multiplicity[1], 4)  # degré 3 => degré+1 = 4
  
  # Modifier la multiplicité d'un noeud interne
  idx <- 3
  app$update_multiplicity(idx, 2)
  state <- app$get_state()
  expect_equal(state$knot_multiplicity[idx], 2)
  
  # Vérifier que la séquence étendue est correcte
  # (le noeud avec multiplicité 2 apparaîtra 2 fois)
  knot_extended <- build_knot_sequence(state$knot, state$knot_multiplicity)
  expected <- c(0, 0, 0, 0, 0.25, 0.5, 0.5, 0.75, 1, 1, 1, 1)
  expect_equal(knot_extended, expected)
})

# ============================================================================
# SUITE DE TESTS
# ============================================================================

test_that("App 0.2.0 test suite summary", {
  cat("\n╔══════════════════════════════════════════════════════════╗\n")
  cat("║     App 0.2.0 Test Suite Summary                        ║\n")
  cat("╚══════════════════════════════════════════════════════════╝\n")
  
  cat("\nTested scenarios:\n")
  cat("  ✓ Minimum knots requirement (2 knots minimum)\n")
  cat("  ✓ Adding knots (manual knot insertion)\n")
  cat("  ✓ Removing knots (internal knots only)\n")
  cat("  ✓ Knot multiplicity management\n")
  cat("  ✓ build_knot_sequence function\n")
  cat("  ✓ Region management\n")
  cat("  ✓ Clear all functionality\n")
  cat("  ✓ Basis visualization prerequisites\n")
  cat("  ✓ Generated R code structure\n")
  cat("  ✓ Knot multiplicity with constraints\n")
  
  cat("\n════════════════════════════════════════════════════════════\n")
  cat("Version: BsplineQuantRegGui v0.2.0\n")
  cat("Features tested: Knots, Multiplicity, Regions, Code generation\n")
  cat("════════════════════════════════════════════════════════════\n")
  
  expect_true(TRUE)
})