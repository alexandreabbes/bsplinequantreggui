# visualisation2.R


  # ============ 3. CONSTRAINTS ============
  conditionalPanel(
    condition = "input.degree < 6",

    h3("3. Constraints", class = "text-primary"),

    radioButtons(
      "constraint_mode",
      "Mode:",
      choices = c("Uniform" = "uniform", "Per region" = "region"),
      selected = "uniform",
      inline = TRUE
    ),

    # Contraintes uniformes
    conditionalPanel(
      condition = "input.constraint_mode == 'uniform'",
      conditionalPanel(
        condition = "input.degree <= 4",
        radioButtons(
          "monot", "Monotonicity:",
          choices = c("x" = "0", "up" = "1", "down" = "-1"),
          selected = "0", inline = TRUE
        )
      ),
      conditionalPanel(
        condition = "input.degree >= 2 & input.degree <= 5",
        radioButtons(
          "conv", "Convexity:",
          choices = c("x" = "0", "U" = "1", "n" = "-1"),
          selected = "0", inline = TRUE
        )
      ),
      conditionalPanel(
        condition = "input.degree >= 3 & input.degree <= 5",
        radioButtons(
          "der3", "Third Derivative:",
          choices = c("x" = "0", "+" = "1", "-" = "-1"),
          selected = "0", inline = TRUE
        )
      )
    ),

    # Contraintes par région
    conditionalPanel(
      condition = "input.constraint_mode == 'region' && input.degree < 6",

      div(style = "font-size: 13px; color: #555; margin-bottom: 10px;",
          "Instructions: 1. Click 'Select' 2. Select a rectangle on the plot.
           Xmin and Xmax fields are updated. 3. Select constraints. 4. Add region"),

      fluidRow(
        column(6, actionButton("start_selection", "Select",
                               class = "btn-sm btn-warning", style = "width:100%;")),
        column(6, actionButton("clear_regions", "Cancel regions",
                               class = "btn-sm btn-danger", style = "width:100%;"))
      ),
      br(),

      fluidRow(
        column(6, numericInput("region_xmin", "X min:", value = 0.3, step = 0.05)),
        column(6, numericInput("region_xmax", "X max:", value = 0.6, step = 0.05))
      ),

      conditionalPanel(
        condition = "input.degree < 5",
        radioButtons(
          "region_monot", "Monotonicity:",
          choices = c("x" = "0", "up" = "1", "down" = "-1"),
          selected = "0", inline = TRUE
        )
      ),

      conditionalPanel(
        condition = "input.degree > 1 && input.degree < 6",
        radioButtons(
          "region_conv", "Convexity:",
          choices = c("x" = "0", "U" = "1", "n" = "-1"),
          selected = "0", inline = TRUE
        )
      ),

      conditionalPanel(
        condition = "input.degree >= 3",
        radioButtons(
          "region_der3", "Third Derivative:",
          choices = c("x" = "0", "+" = "1", "-" = "-1"),
          selected = "0", inline = TRUE
        )
      ),

      fluidRow(
        column(6, actionButton("add_region", "Add region",
                               class = "btn-sm btn-primary", style = "width:100%;")),
        column(6, actionButton("update_region", "Update",
                               class = "btn-sm btn-info", style = "width:100%;"))
      ),
      br(),

      div(id = "regions_list", style = "max-height: 120px; overflow-y: auto;")
    )
  ),

  # ============ 4. EXECUTION ============
  h3("4. Execution"),

  h5("Color:"),

  fluidRow(
    column(6, colourpicker::colourInput("curve_color", NULL, value = "blue")),
    column(6, actionButton("apply_color", "Apply", class = "btn-sm"))
  ),

  p("Curves:", textOutput("curve_count", inline = TRUE)),

  fluidRow(
    column(6, actionButton("run", "Run", class = "btn-success btn-lg")),
    column(6, actionButton("clear_all", "Clear all", class = "btn-sm btn-danger"))
  ),

  br(),

  fluidRow(
    column(6, actionButton("clear_curves", "Clear last curve", class = "btn-sm btn-warning")),
    column(6, actionButton("clear_all_curves", "Clear all curves", class = "btn-sm btn-danger"))
  )

  # ← fermeture du column(width=3.5)
