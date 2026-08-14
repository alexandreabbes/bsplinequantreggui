#--------------------------------------------------
#====================================================
#=================FUNCTIONS==========================
#=This section is dedicated to functions for the App=
#====================================================
#-----------------------------------------------------


# ============ KNOT MANAGEMENT ============

# Construire la séquence de nœuds avec multiplicités
build_knot_sequence <- function(knots, multiplicities)
  {
  # Vérifier les entrées
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


# Initialiser les nœuds avec multiplicités
init_knots <- function(xtab, n_knots) {
  # Générer des nœuds quantiles
  knots <- as.numeric(quantile(xtab, probs = seq(0, 1, length.out = n_knots + 1)))

  # Multiplicités initiales (1 par défaut pour les nœuds internes)
  # Les extrémités ont multiplicité degree + 1
  degree <- input$degree
  mult <- rep(1, length(knots))
  mult[1] <- degree + 1
  mult[length(mult)] <- degree + 1

  return(list(knots = knots, multiplicities = mult))
}




# Mettre à jour la multiplicité d'un nœud
update_knot_multiplicity <- function(idx, new_mult) {
  if (is.null(values$knot)) return()
  if (idx < 1 || idx > length(values$knot)) return()

  # Ne pas modifier les extrémités
  if (idx == 1 || idx == length(values$knot)) {
    showNotification("Cannot modify endpoint knots!", type = "warning")
    return()
  }

  # Limiter la multiplicité
  degree <- input$degree
  new_mult <- max(1, min(new_mult, degree + 1))

  # Mettre à jour les métadonnées
  values$knot_multiplicity[idx] <- new_mult

  # Reconstruire la séquence étendue
  values$knot_extended <- build_knot_sequence(
    values$knot,
    values$knot_multiplicity
  )

  # Garder le vecteur knot pour compatibilité
  values$knot <- values$knot

  showNotification(paste("Knot", idx, "multiplicity set to", new_mult),
                   type = "message")
}

#========== Demo Execution ==============


execute_demo <- function(demo_name) {
  showNotification(paste("Running demo:", demo_name), type = "message")

  withProgress(message = paste("Running", demo_name, "..."), {
    # Récupérer la hauteur depuis la liste
    demo_height <- demo_heights[[demo_name]] %||% 800
    demo_width <- if (demo_name == "derivative2")
      1500
    else
      800
    # Créer un fichier temporaire pour l'image
    temp_file <- tempfile(fileext = ".png")

    # Ouvrir un device PNG

    png(temp_file,
        width = demo_width,
        height = demo_height,
        res = 120)

    # Créer un environnement avec la variable degree
    demo_env <- new.env()
    demo_env$degree <- input$degree
    demo_env$par <- graphics::par
    demo_results$height <- demo_height

    # Capturer la sortie
    output_text <- capture.output({
      tryCatch({
        with(demo_env, {
          source(
            system.file("demo", paste0(demo_name, ".R"), package = "BsplineQuantReg"),
            local = TRUE,
            echo = FALSE
          )
        })
      }, error = function(e) {
        cat("Error:", e$message, "\n")
      })
    })

    # Fermer le device
    dev.off()

    # Lire l'image
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


# ============ CONSTRAINT SYMBOL FUNCTION ============
get_sym <- function(val, symbols) {
  if (is.null(val) || is.na(val))
    return("x")
  val <- as.numeric(val)
  if (!val %in% c(-1, 0, 1))
    return("x")
  return(symbols[val + 2])
}

# ============ FIELD UPDATE FUNCTION ============
update_region_fields <- function(xmin, xmax) {
  if (is.null(xmin) ||
      is.null(xmax) || is.na(xmin) || is.na(xmax))
    return()
  if (xmin >= xmax) {
    showNotification("X min must be less than X max", type = "warning")
    return()
  }
  updateNumericInput(session, "region_xmin", value = round(xmin, 3))
  updateNumericInput(session, "region_xmax", value = round(xmax, 3))
}


# ============ CONSTRAINT CONSTRUCTION ============

build_constraints <- function() {


  if (is.null(values$knot)) {
    showNotification("No knots available!", type = "warning")
    return(NULL)
  }
  degree <- input$degree
  kn <- length(values$knot) - 1

  # Contraintes uniformes
  if (input$constraint_mode == "uniform") {
    monot_val <- as.numeric(input$monot)
    conv_val <- as.numeric(input$conv)
    der3_val <- as.numeric(input$der3)

    if (is.na(monot_val)) monot_val <- 0
    if (is.na(conv_val)) conv_val <- 0
    if (is.na(der3_val)) der3_val <- 0

    monot <- rep(monot_val, kn+1)
    conv <- rep(conv_val, kn + 1)
    der3 <- rep(der3_val, kn + 1)

    if (degree < 3) {der3 <- rep(0, kn + 1)}

  }
  else {
    # Mode région
    monot <- rep(0, kn+1)
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
  if (input$consider_multiplicity){
    mult_monot<-c(monot[1])
    mult_conv<-c(conv[1])
    mult_der3<-c(der3[1])
    for (i in 2:kn)
    { mult_monot<-c(mult_monot,rep(monot[i],values$knot_multiplicity[i]))
    mult_conv<-c(mult_conv,rep(conv[i],values$knot_multiplicity[i]))
    mult_der3<-c(mult_der3, rep(der3[i],values$knot_multiplicity[i]))
    }
    mult_monot<-c(mult_monot,monot[kn+1])
    mult_conv<-c(mult_conv,conv[kn+1])
    mult_der3<-c(mult_der3,der3[kn+1])

    monot<-mult_monot
    conv<-mult_conv
    der3<-mult_der3
  }

  return(list(
    monot = monot,
    conv = conv,
    der3 = der3
  ))
}

#=============================================================
#                     END OF FUNCTION SECTION
#-------------------------------------------------------------
#=============================================================


