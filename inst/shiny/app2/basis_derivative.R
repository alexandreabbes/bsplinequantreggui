

basis_update<-function()
{
  if (is.null(values$knot)){showNotification("No knot available",type="warning")
    return()}
  else{
    if (length(values$knot)<2) {
      showNotification("Need at least 2 knots",type="warning")
      return()}
    else{

      withProgress(message = "Generating basis...", {
        degree <- values$degree

        knot <- values$knot
        if (input$consider_multiplicity){
          mult<-values$knot_multiplicity
        }
        else {
          mult<-c(values$degree+1,rep(1,(length(values$knot)-2)),values$degree+1)
        }


        sn <- build_knot_sequence(values$knot,mult)
        # Construire la base
        basis_obj <- Bspline_base(sn, degree = degree, verbose = FALSE)

        knot <- values$knot

        if (input$verbose){
          log_console(paste("Basis knots:", paste(round(knot, 4), collapse = ", ")))
        }
        # Dériver si nécessaire
        der <- input$basis_derivative
        if (der > 0) {
          der_basis_obj <- Bspline_base_deriv(basis_obj, der = der, verbose = FALSE)
        } else {
          der_basis_obj <- basis_obj
        }

        # Points d'évaluation (avec une marge)
        x_min <- min(knot) - 0.02 * diff(range(knot))
        x_max <- max(knot) + 0.02* diff(range(knot))
        x_eval <- seq(x_min, x_max, length.out = 300)

        # Stocker
        basis_values$basis_obj <- basis_obj
        basis_values$der_basis_obj <- der_basis_obj
        basis_values$x_eval <- x_eval
        basis_values$derivative <- der


        # Initialiser les multiplicités (1 par défaut)

        showNotification(paste("Basis generated (degree", degree, ",", length(knot), "knots)"),
                         type = "message")

      }) # end "with progrees"

    }# end else
  } # end else
} #end action

# ============================================================================
# AFFICHAGE DES COEFFICIENTS DES DÉRIVÉES
# ============================================================================
display_derivatives<-function()
{
  selected <- input$deriv_display
  if (selected == "none") return()

  n_deriv <- as.numeric(selected)

  for (d in 1:n_deriv) {
    local({
      der <- d
      output_name <- paste0("deriv_coeff_", der)

      output[[output_name]] <- renderPrint({
        req(values$fitted)

        # Calculer la dérivée
        deriv_spline <- Bspline_deriv(values$fitted, der = der)

        # Convertir en PP
        deriv_pp <- Bsplinetopp(deriv_spline, callable = FALSE)

        local_display <- if (is.null(input$local)) TRUE else as.logical(input$local)

        coeff_matrix <- deriv_pp$coeff
        knot <- deriv_pp$knot

        cat("Derivative order:", der, "\n")
        cat("Degree:", values$degree-der, "\n")
        cat("Number of intervals:", length(knot) - 1, "\n\n")

        if (is.matrix(coeff_matrix)) {
          cat("Polynomial coefficients on each interval:\n\n")
          for (i in 1:nrow(coeff_matrix)) {
            cat(sprintf("[%.4f, %.4f]: ", knot[i], knot[i+1]))
            poly_str <- show_poly(coeff_matrix[i, ],
                                  a = knot[i],
                                  b = if (local_display) knot[i] else 0,
                                  digits = 4)
            cat(poly_str, "\n")
          }
        } else {
          cat("Polynomial coefficients:\n")
          poly_str <- show_poly(coeff_matrix,
                                a = knot[1],
                                b = if (local_display) knot[1] else 0,
                                digits = 4)
          cat(poly_str, "\n")
        }
      } )
    })
  }

}

# ============================================================================
# RENDU DES PLOTS DE DÉRIVÉES
# ============================================================================
plot_derivatives<-function()
{
  selected <- input$deriv_display
  if (selected == "none") return()

  n_deriv <- as.numeric(selected)

  for (d in 1:n_deriv) {
    local({
      der <- d
      output_name <- paste0("deriv_plot_", der)

      output[[output_name]] <- renderPlotly({
        req(values$fitted)
        req(values$xtab)

        # Calculer la dérivée
        deriv_spline <- Bspline_deriv(values$fitted, der = der)

        x_vals <- seq(min(values$xtab, na.rm = TRUE),
                      max(values$xtab, na.rm = TRUE),
                      length.out = 300)

        # Évaluer la dérivée : callable b-spline

        param<-get_parameters(deriv_spline)
        # exception pour degree 1 et 1 seul intervalle
        #version<-packageVersion("BsplineQuantReg")
        #exception025<-(param$degree==0 && length(values$knot)==2) && (version<"0.2.6")
        #if (exception025)
        #{
        #  #showNotification("Exception025", type="warning")
        #  y_vals=rep(param$coeff,length(x_vals))}
        #else
        y_vals <- deriv_spline(x_vals)

        colors <- c("blue", "darkgreen", "purple")
        deriv_names <- c("1st derivative", "2nd derivative", "3rd derivative")

        plot_ly(
          x = x_vals,
          y = y_vals,
          type = "scatter",
          mode = "lines",
          line = list(color = colors[der], width = 2),
          name = deriv_names[der]
        ) %>%
          layout(
            title = deriv_names[der],
            xaxis = list(title = "x"),
            yaxis = list(title = paste0("f^(", der, ")(x)")),
            hovermode = "closest"
          )

      }) #end renderplotly
    }) # end local
  } # end for
}
