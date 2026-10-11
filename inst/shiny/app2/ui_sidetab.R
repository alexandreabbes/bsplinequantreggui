column(width=3,
  style="background-color: #f8f9fa; border-radius: 5px;",

  # ============ 1. DATA ============
  h3("1. Data", class = "text-primary"),

  div(
    style = "display: flex; flex-wrap: wrap; gap: 5px;",
    actionButton("test_data", "Test", class = "btn-sm btn-success", style = " background-color:#000000;"),
    actionButton("temp_data", "Temp", class = "btn-sm btn-warning", style = "background-color:#FF0000;"),
    actionButton("load_csv", "CSV", class = "btn-sm btn-info", style = "background-color:#10AA10;")
  ),
  br(),

  h5("Interval:"),
  h6(fluidRow(
    column(
      4,
      numericInput("data_xmin", "X min:", value = 0, step = 0.05),
      style = "padding-right: 1px;"
    ),
    column(
      4,
      numericInput("data_xmax", "X max:", value = 1, step = 0.05),
      style = "padding-right: 1px;"
    ),
    column(
      4,
      numericInput(
        "n_points",
        "n:",
        value = 100,
        min = 10,
        max = 1000
      ),
      style = "padding-right: 1px;"
    )
  )),


  fluidRow(column(
    12,
    textInput("custom_func",
              actionButton("generate_custom", "Generate", class = "btn-sm btn-primary"),
              value = "2*x + 0.5*sin(6*pi*x) + 0.2*rnorm(n)")
  )
  ),



  hr(),

  # ============ 2. SPLINE ============
  h3("2. Spline", class = "text-primary"),

  fluidRow(column(
    6, numericInput(
      "degree",

      h6("Degree:"),
      value = 3,
      min = 0#,
      #          max = 4
    )
  ), column(
    6,
    numericInput(
      "auto_knot_count",
      actionButton("set_auto_knots", "set auto knots", class = "btn-sm btn-primary"),
      value = 10,
      min = 2,
      max = 30
    ),


  )),

  br(),

  fluidRow(sliderInput(
    "tau",
    "Tau:",
    min = 0.05,
    max = 0.95,
    value = 0.5
  )),
  br(),
  fluidRow(h6(column(6, selectInput("solver","Solver:",
                                    choices = c("ECOS", "SCS","CLARABEL", "HIGHS", "OSQP", "GUROBI") ) ),
              column(6,selectInput("type_reg","Type of Regr.",
                                   choices=c('quantile','mean_square') ) ))),
  fluidRow(h6(column(
    6, checkboxInput("verbose", "Verbose", FALSE)
  )

  )),

  hr(),

  #  5. Demos" :

  h3("5. Demos", class = "text-primary"),
  div(
    style = "display: flex; flex-wrap: wrap; gap: 5px;",
    actionButton(
      "demo_comp",
      "Comprehensive",
      class = "btn-sm btn-info",
      style = "flex:1;"
    ),
    actionButton(
      "demo_monot",
      "Monotonicity Basic",
      class = "btn-sm btn-info",
      style = "flex:1;"
    ),
    actionButton("demo_log", "Logistic", class = "btn-sm btn-info", style = "flex:1;"),
    actionButton(
      "demo_temp",
      "Temperature",
      class = "btn-sm btn-info",
      style = "flex:1;"
    ),
    actionButton(
      "demo_temp2",
      "Temperature2",
      class = "btn-sm btn-info",
      style = "flex:1;"
    ),
    actionButton("demo_conv", "Convexity", class = "btn-sm btn-info", style = "flex:1;"),
    actionButton("demo_degrees", "Degrees", class = "btn-sm btn-info", style = "flex:1;"),
    actionButton(
      "demo_der3",
      "Third derivative",
      class = "btn-sm btn-info",
      style = "flex:1;"
    ),
    actionButton(
      "demo_derivative",
      "Derivative",
      class = "btn-sm btn-info",
      style = "flex:1;"
    ),
    actionButton(
      "demo_shock",
      "Shock",
      class = "btn-sm btn-info",
      style = "flex:1;"
    ),
    actionButton(
      "demo_shock_basis",
      "Shock and basis",
      class = "btn-sm btn-info",
      style = "flex:1;"
    )
  ),

  div(
    style = "font-size: 11px; color: #666; text-align: center;",
    p("BsplineQuantRegGui v0.1.0"),
    p("BsplineQuantReg 0.2.2"),
    p("GPL3 (c) Abbes, 2026"),
    a("GitHub", href = "https://github.com/alexandreabbes/BsplineQuantReg", target = "_blank")
  )
)

