fluidRow(
  column(
    3,

    hr(),
    h4("Derivative"),
    sliderInput("basis_derivative", "Derivative order:",
                min = 0, max = 4, value = 0, step = 1),
    hr(),
    h4("Display"),
    checkboxInput("basis_show_knots", "Show knots", value = TRUE),
    checkboxInput("basis_show_multiplicity", "Show multiplicity labels", value = TRUE),
    actionButton("basis_update", "Update Basis",
                 class = "btn-primary btn-block"),
    checkboxInput("consider_multiplicity","Consider Interal Multiplicities",value=TRUE),


    hr(),
    h4("Knot Multiplicities"),
    verbatimTextOutput("multiplicity_info", placeholder = TRUE),

    hr()

  ),
  column(
    9,
    plotOutput("basis_plot", height = "600px", click = "basis_plot_click"),
    br(),
    h5("Basis Information"),
    verbatimTextOutput("basis_info", placeholder = TRUE)
  ))
