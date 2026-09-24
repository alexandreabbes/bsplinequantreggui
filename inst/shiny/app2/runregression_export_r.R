#===================================
#== run regression
#==================================

run_regression<-function()
{
  req(values$xtab, values$ytab, values$knot)

  if (length(values$knot) < 2) {
    showNotification("Need at least 2 knots!", type = "error")
    return()
  }

  if (length(values$xtab) != length(values$ytab)) {
    showNotification("x and y have different lengths!", type = "error")
    return()
  }

  withProgress(message = "Regression...", {
    constraints <- build_constraints()
    if (is.null(constraints)) return()

    log_console("=== Starting Regression ===")
    log_console(paste("Degree:", values$degree))
    log_console(paste("Solver:", input$solver))
    log_console(paste("Verbose:", input$verbose))

    # Vérifier la version de BsplineQuantReg
    version <- packageVersion("BsplineQuantReg")
    #Extended knot sequence with interior multiplicities (regularity control)
    #if (values$degree==1 && input$consider_multiplicity && any(constraints$monot!=0)){
    #  showNotification("Constraints do not work now with multplie knots for degree 1", type="warning" )
    #  }
    if (input$consider_multiplicity)
    {
      mult_knot<-build_knot_sequence(
        values$knot,
        values$knot_multiplicity)
      lm<-length(mult_knot)
      knot<-mult_knot[(values$degree+1):(lm-values$degree)]}
    else{
      knot<-as.vector(values$knot)
    }

    # Paramètres communs
    args <- list(
      as.vector(values$xtab),
      as.vector(values$ytab),
      knot=knot, #
      tau = input$tau,
      degree = as.numeric(values$degree),
      monot = constraints$monot,
      convcons = constraints$conv,
      der3cons = constraints$der3,
      solver = as.logical(input$solver),
      verbose = input$verbose,
      callable = TRUE
    )
    if (input$verbose) log_console(print(args$knot ))

    # Ajouter le paramètre type_reg si la version est >= 0.2.3
    if (version >= "0.2.3") {
      args$type_reg <- input$type_reg
    }

    console_text <- character()
    #problem in special case constraints with multiplicities and degree==1
    tn=length(knot)

    # Rediriger stdout
    sink(tempfile())

    # Capturer les messages
    withCallingHandlers({
      output <- capture.output({
        fitted <- do.call(quantile_spline, args)
      })




    }, message = function(m) {
      console_text <<- c(console_text, m$message)
    })

    # Restaurer stdout
    sink()

    # Ajouter la sortie standard
    console_all <- output

    log_console(console_all)


    # Traiter le résultat
    if (!is.null(fitted)) {
      x_eval <- seq(min(values$xtab), max(values$xtab), length.out = 300)
      y_eval <- fitted(x_eval)
      values$fitted <- fitted
      values$x_eval <- x_eval
      values$y_eval <- y_eval
      color <- input$curve_color
      values$curve_lines <- c(values$curve_lines,list(list(
        x = x_eval,
        y = y_eval,
        color = color
      )))
      showNotification("Regression successful!", type = "message")
    } else {
      log_console("=== Regression failed ===", "error")
    }
  })
  clean_ansi <- function(text) {
    text <- gsub("gG3;", "", text)
    text <- gsub("G3;", "", text)
    text <- trimws(text)
    return(text)
  }

  #log_console(clean_ansi(console_text))

  for (line in console_text) {
    if (nchar(line) > 0) {
      line = clean_ansi(line)
      log_console(paste(line))
    }
  }


  log_console(paste("BsplineQuantReg version:", packageVersion("BsplineQuantReg")))
  if (!is.null(fitted)) {


  }
}



#################################################
#########  export R CODE #########################
##################################################

make_r_code<-function()
{
  if (is.null(values$fitted)) {
    return("# Run a regression first")
  }
  constraints <- build_constraints()
  if (is.null(constraints)) {
    return("# Error: constraints not defined")
  }
  ###########adding derivatives##############
  n_deriv <-0
  if (input$deriv_display!="none")
    n_deriv <-as.numeric(input$deriv_display)
  n_plots <- n_deriv + 1
  deriv_plot=""
  deriv_code=""

  if (n_deriv > 0) {
    deriv_plot<-paste("#### Add plots of the derivatives #### \n")

    colors <- c("blue", "darkgreen", "purple")


    for (d in 1:n_deriv) {
      deriv_code <- paste0(deriv_code, "\n# ", " derivative",d,"\n")
      deriv_code <- paste0( deriv_code, "deriv_", d, " <- Bspline_deriv(fitted, der = ", d, ")\n" )

      # Ajouter l'évaluation
      deriv_code <- paste0(deriv_code, "deriv_", d, "_eval <- deriv_", d, "(x_eval)\n")

      deriv_plot <- paste0(deriv_plot, "plot(x_eval, deriv_",d, "_eval," , "pch = 16, cex = 0.5, col = 'gray',\n",
                           "     main = 'Spline  derivatives", d,"')" , "\n" )

      deriv_plot <- paste0(deriv_plot,
                           "lines(x_eval, deriv_", d, "_eval, col = '",
                           colors[d], "', lwd = 1.5, lty = ", d+1, ")\n")
    }



  }

  paste0(
    "library(BsplineQuantReg)\n\n",
    "x <- c(",
    paste(round(values$xtab, 4), collapse = ", "),
    ")\n",
    "y <- c(",
    paste(round(values$ytab, 4), collapse = ", "),
    ")\n",
    "knot <- c(",
    paste(round(values$knot, 4), collapse = ", "),
    ")\n\n",
    "fitted <- quantile_spline(x, y, knot,\n",
    "                       tau = ",
    input$tau,
    ",\n",
    "                       degree = ",
    values$degree,
    ",\n",
    "                       monot = c(",
    paste(constraints$monot, collapse = ", "),
    "),\n",
    "                       convcons = c(",
    paste(constraints$conv, collapse = ", "),
    "),\n",
    "                       der3cons = c(",
    paste(constraints$der3, collapse = ", "),
    "),\n",
    "                       solver = '",
    input$solver,
    "',\n",
    "                       callable = TRUE)\n\n",
    "x_eval <- seq(min(x), max(x), length.out = 300)\n",
    "y_eval <- fitted(x_eval)\n\n",
    "par(mfrow=c(",n_plots,",1))\n",
    "plot(x, y, pch = 16, cex = 0.5, col = 'gray',main='fitted spline')\n",
    "lines(x_eval, y_eval, col = '",
    input$curve_color,
    "', lwd = 2)\n",
    "#PP-Polynomial coefficients of spline\n",
    "Co=show_pp(fitted,local=",input$local,")", "\n",
    "print(Co)\n",
    deriv_code,
    deriv_plot
  )
}




#============== DEMO  ==================

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
    demo_env$degree <- values$degree
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


