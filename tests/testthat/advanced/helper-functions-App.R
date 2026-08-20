# helper-functions-App.R

# ============================================================================
# FONCTIONS INTERNES - UTILISÉES UNIQUEMENT DANS L'APPLICATION SHINY
# ============================================================================
# Ces fonctions sont conçues pour être exécutées dans l'environnement de
# l'application Shiny où les objets 'input', 'values', 'session' et les
# fonctions 'showNotification', 'updateNumericInput', etc. sont disponibles.
# ============================================================================

# ============ KNOT MANAGEMENT ============

#' Build knot sequence with multiplicities
#'
#' Internal function for Shiny app. Not exported.
#'
#' @param knots Vector of unique knot positions
#' @param multiplicities Vector of multiplicities for each knot
#' @return Extended knot sequence
#' @keywords internal
#' @noRd
build_knot_sequence <- function(knots, multiplicities) {
  if (is.null(knots) || length(knots) == 0) {
    return(c())
  }
  if (is.null(multiplicities) || length(multiplicities) != length(knots)) {
    stop("knots and multiplicities must have same length")
  }

  knot_seq <- c()
  for (i in seq_along(knots)) {
    knot_seq <- c(knot_seq, rep(knots[i], multiplicities[i]))
  }
  return(knot_seq)
}

#' Initialize knots with multiplicities
#'
#' Internal function for Shiny app. Not exported.
#' Requires 'input' object from Shiny session.
#'
#' @param xtab Data vector
#' @param n_knots Number of knots
#' @return List with knots and multiplicities
#' @keywords internal
#' @noRd
init_knots <- function(xtab, n_knots) {
  # Utilise 'input' de l'environnement Shiny
  degree <- input$degree
  knots <- as.numeric(quantile(xtab, probs = seq(0, 1, length.out = n_knots + 1)))
  mult <- rep(1, length(knots))
  mult[1] <- degree + 1
  mult[length(mult)] <- degree + 1
  return(list(knots = knots, multiplicities = mult))
}

#' Update knot multiplicity
#'
#' Internal function for Shiny app. Not exported.
#' Requires 'input', 'values', and 'showNotification' from Shiny.
#'
#' @param idx Index of knot to update
#' @param new_mult New multiplicity value
#' @keywords internal
#' @noRd
update_knot_multiplicity <- function(idx, new_mult) {
  if (is.null(values$knot)) return()
  if (idx < 1 || idx > length(values$knot)) return()

  if (idx == 1 || idx == length(values$knot)) {
    showNotification("Cannot modify endpoint knots!", type = "warning")
    return()
  }

  degree <- input$degree
  new_mult <- max(1, min(new_mult, degree + 1))
  values$knot_multiplicity[idx] <- new_mult
  values$knot_extended <- build_knot_sequence(values$knot, values$knot_multiplicity)
  values$knot <- values$knot
  showNotification(paste("Knot", idx, "multiplicity set to", new_mult), type = "message")
}

# ============ CONSTRAINT SYMBOL FUNCTION ============

#' Get constraint symbol
#'
#' Convert numeric constraint value to symbol. This function is safe to export.
#'
#' @param val Numeric value (-1, 0, 1)
#' @param symbols Character vector of symbols
#' @return Symbol string
#' @export
get_sym <- function(val, symbols) {
  if (is.null(val) || is.na(val)) return("x")
  val <- as.numeric(val)
  if (!val %in% c(-1, 0, 1)) return("x")
  return(symbols[val + 2])
}

#' Update region fields
#'
#' Internal function for Shiny app. Not exported.
#' Requires 'session' and 'showNotification' from Shiny.
#'
#' @param xmin Minimum x value
#' @param xmax Maximum x value
#' @keywords internal
#' @noRd
update_region_fields <- function(xmin, xmax) {
  if (is.null(xmin) || is.null(xmax) || is.na(xmin) || is.na(xmax)) return()
  if (xmin >= xmax) {
    showNotification("X min must be less than X max", type = "warning")
    return()
  }
  updateNumericInput(session, "region_xmin", value = round(xmin, 3))
  updateNumericInput(session, "region_xmax", value = round(xmax, 3))
}

# ============ CONSTRAINT CONSTRUCTION ============

#' Build constraints for regression
#'
#' Internal function for Shiny app. Not exported.
#' Requires 'input', 'values', and 'showNotification' from Shiny.
#'
#' @return List of constraint vectors
#' @keywords internal
#' @noRd
build_constraints <- function() {
  if (is.null(values$knot)) {
    showNotification("No knots available!", type = "warning")
    return(NULL)
  }

  degree <- input$degree
  kn <- length(values$knot) - 1

  if (input$constraint_mode == "uniform") {
    monot_val <- as.numeric(input$monot)
    conv_val <- as.numeric(input$conv)
    der3_val <- as.numeric(input$der3)

    if (is.na(monot_val)) monot_val <- 0
    if (is.na(conv_val)) conv_val <- 0
    if (is.na(der3_val)) der3_val <- 0

    monot <- rep(monot_val, kn + 1)
    conv <- rep(conv_val, kn + 1)
    der3 <- rep(der3_val, kn + 1)

    if (degree < 3) der3 <- rep(0, kn + 1)
  } else {
    monot <- rep(0, kn + 1)
    conv <- rep(0, kn + 1)
    der3 <- rep(0, kn + 1)

    for (region in values$regions) {
      for (i in 1:kn) {
        x1 <- values$knot[i]
        x2 <- values$knot[i + 1]
        if (x2 > region$xmin && x1 < region$xmax) {
          if (region$monot != 0) monot[i] <- region$monot
          if (region$conv != 0) {
            conv[i] <- region$conv
            conv[i + 1] <- region$conv
          }
          if (region$der3 != 0 && degree >= 3) {
            der3[i] <- region$der3
          }
        }
      }
    }
  }

  if (input$consider_multiplicity) {
    mult_monot <- c(monot[1])
    mult_conv <- c(conv[1])
    mult_der3 <- c(der3[1])

    for (i in 2:kn) {
      mult_monot <- c(mult_monot, rep(monot[i], values$knot_multiplicity[i]))
      mult_conv <- c(mult_conv, rep(conv[i], values$knot_multiplicity[i]))
      mult_der3 <- c(mult_der3, rep(der3[i], values$knot_multiplicity[i]))
    }

    mult_monot <- c(mult_monot, monot[kn + 1])
    mult_conv <- c(mult_conv, conv[kn + 1])
    mult_der3 <- c(mult_der3, der3[kn + 1])

    monot <- mult_monot
    conv <- mult_conv
    der3 <- mult_der3
  }

  return(list(monot = monot, conv = conv, der3 = der3))
}

# ============ DEMO EXECUTION ============

#' Execute a demo
#'
#' Internal function for Shiny app. Not exported.
#' Requires Shiny environment with 'input', 'demo_heights', etc.
#'
#' @param demo_name Name of the demo to execute
#' @keywords internal
#' @noRd
execute_demo <- function(demo_name) {
  showNotification(paste("Running demo:", demo_name), type = "message")

  withProgress(message = paste("Running", demo_name, "..."), {
    demo_height <- demo_heights[[demo_name]] %||% 800
    demo_width <- if (demo_name == "derivative2") 1500 else 800
    temp_file <- tempfile(fileext = ".png")

    png(temp_file, width = demo_width, height = demo_height, res = 120)

    demo_env <- new.env()
    demo_env$degree <- input$degree
    demo_env$par <- graphics::par
    demo_results$height <- demo_height

    output_text <- capture.output({
      tryCatch({
        with(demo_env, {
          source(system.file("demo", paste0(demo_name, ".R"), package = "BsplineQuantReg"),
                 local = TRUE, echo = FALSE)
        })
      }, error = function(e) {
        cat("Error:", e$message, "\n")
      })
    })

    dev.off()

    if (file.exists(temp_file)) {
      img <- png::readPNG(temp_file)
      demo_results$plot <- grid::rasterGrob(img, interpolate = TRUE)
      unlink(temp_file)
    } else {
      demo_results$plot <- NULL
    }

    demo_results$output <- output_text
    runjs('document.getElementById("demo_area").style.display = "block";')
  })
}
