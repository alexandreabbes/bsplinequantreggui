

    conditionalPanel(
    condition = "input.degree<6",

    h3("3. Constraints", class = "text-primary"),
    radioButtons(
      "constraint_mode",
      "Mode:",
      choices = c("Uniform" = "uniform", "Per region" = "region"),
      selected = "uniform",
      inline = TRUE
    ),

    conditionalPanel(
      condition = "input.constraint_mode == 'uniform'",
      conditionalPanel(
        condition = "input.degree<=4",
        radioButtons(
          "monot",
          "Monotonicity:",
          choices = c("x" = "0", "up" = "1", "down" = "-1"),
          selected = "0",
          inline = TRUE
        )
      ),
      conditionalPanel(
        condition = "input.degree>=2 & input.degree<=5",
        radioButtons(
          "conv",
          "Convexity:",
          choices = c("x" = "0", "U" = "1", "n" = "-1"),
          selected = "0",
          inline = TRUE
        )),
      conditionalPanel(
        condition = "input.degree >= 3 & input.degree <= 5 ",
        radioButtons(
          "der3",
          "Third Derivative:",
          choices = c("x" = "0", "+" = "1", "-" = "-1"),
          selected = "0",
          inline = TRUE
        )
      )
    )
  ), # end uniform constraints panel

  conditionalPanel(
    condition = "input.constraint_mode == 'region' && input.degree<6",
    div(style = "font-size: 13px; color: #555; margin-bottom: 10px;", "1. Click 'Select'"),
    div(style = "font-size: 13px; color: #555; margin-bottom: 10px;", "2. Select a region on the plot"),
    div(style = "font-size: 13px; color: #555; margin-bottom: 10px;", "X min/max fields are updated"),
    div(style = "font-size: 13px; color: #555; margin-bottom: 10px;", "3. Select constraints"),
    div(style = "font-size: 13px; color: #555; margin-bottom: 10px;", "4. Click 'Add reggion'"),
    div(style = "font-size: 13px; color: #555; margin-bottom: 10px;", "5. Last selected region can \n be modified and updated"),


    fluidRow(column(
      3,
      actionButton(
        "start_selection",
        "Select",
        class = "btn-sm btn-warning",
        style = "width:100%;"
      )
    ), column(
      3,
      actionButton(
        "clear_regions",
        "Cancel regions",
        class = "btn-sm btn-danger",
        style = "width:100%;"
      )
    )),
    br(),

    fluidRow(column(
      3, numericInput("region_xmin", "X min:", value = 0.3, step = 0.05)
    ), column(
      3, numericInput("region_xmax", "X max:", value = 0.6, step = 0.05)
    )),

    conditionalPanel(
      condition = "input.degree<5",
      radioButtons(
        "region_monot",
        "Monotonicity:",
        choices = c("x" = "0", "up" = "1", "down" = "-1"),
        selected = "0",
        inline = TRUE
      )),

    conditionalPanel(
      condition = "input.degree>1 && input.degree<6",
      radioButtons(
        "region_conv",
        "Convexity:",
        choices = c("x" = "0", "U" = "1", "n" = "-1"),
        selected = "0",
        inline = TRUE
      )),
    conditionalPanel(
      condition = "input.degree >= 3",
      radioButtons(
        "region_der3",
        "Third Derivative:",
        choices = c("x" = "0", "+" = "1", "-" = "-1"),
        selected = "0",
        inline = TRUE
      )
    ),


    fluidRow(column(
      3,
      actionButton("add_region", "Add region", class = "btn-sm btn-primary", style = "width:100%;")
    ), column(
      6,
      actionButton("update_region", "Update", class = "btn-sm btn-info", style = "width:100%;")
    )),

    br(),
    div(id = "regions_list", style = "max-height: 120px; overflow-y: auto;")
  ),

  # ============ 4. EXECUTION ============

  h3("4. Execution"),

  h5("Color:"),
  fluidRow(
    column(
      3,
      colourpicker::colourInput("curve_color", NULL, value = "blue")
    ),
    column(6, actionButton("apply_color", "Apply", class = "btn-sm"))
  ),

  p("Curves:", textOutput("curve_count", inline = TRUE)),


  fluidRow(column(3,actionButton("run", "Run", class = "btn-success btn-lg"),
                  br(),
                  actionButton("clear_all", "Clear all", class = "btn-sm btn-danger")),
           column(3,actionButton("clear_curves", "Clear last curve", class = "btn-sm btn-warning"),br(),
                  actionButton("clear_all_curves", "Clear all curves", class = "btn-sm btn-danger")
           )

  )

