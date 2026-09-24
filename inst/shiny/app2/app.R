# BsplineQuantReg Shiny Interface
# Author: Alexandre Abbes

# Version 0.2.3
# Run with:
# shiny::runApp("R/run_gui.R")


library(BsplineQuantReg)


library(shiny)
library(shinyjs)
library(ECOSolveR)

library(DT)
library(plotly)
library(colourpicker)
library(shinythemes)
library(png)

# UI ----------------------------------------------------------------------

ui <- fluidPage(
  theme = shinytheme("flatly"),
  useShinyjs(),
  tags$style(
    HTML(
      "
    .shiny-notification-success {
      background-color: #d4edda;
      border-color: #c3e6cb;
      color: #155724;
    }
    .region-box {
      border: 2px solid #ff9800;
      background-color: rgba(255, 152, 0, 0.15);
      border-radius: 5px;
      padding: 8px;
      margin: 4px 0;
    }
  "
    )
  ),

  titlePanel(
    h2(
      "BsplineQuantReg - Quantile Regression with B-Splines under Shape Constraints",
      align = "center",
      style = "color: #2c3e50;"
    ),
    windowTitle = "BsplineQuantRegGui"
  ),
  #themeSelector(),
  div(
    style = "position: absolute; top: 10px; right: 20px; z-index: 1000;",
    actionButton("toggle_theme", "Themes", class = "btn-sm btn-outline-secondary", style = "border-radius: 20px; padding: 5px 15px;")
  ),

  # Et la zone pour le theme Selector (cachée par défaut)
  div(
    id = "theme_selector_area",
    style = "display: none; position: absolute; top: 50px; right: 20px; z-index: 1000;
           background: white; padding: 15px; border-radius: 8px;
           box-shadow: 0 4px 12px rgba(0,0,0,0.15); width: 250px;",
    h5("Select Theme:"),
    themeSelector()
  ),
  sidebarLayout(
    sidebarPanel(
      width = 3,
      style = "background-color: #f8f9fa; border-radius: 5px;",

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
      ), ),



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
        )
      ),

      div(
        style = "font-size: 11px; color: #666; text-align: center;",
        p("BsplineQuantRegGui v0.1.0"),
        p("BsplineQuantReg 0.2.2"),
        p("GPL3 (c) Abbes, 2026"),
        a("GitHub", href = "https://github.com/alexandreabbes/BsplineQuantReg", target = "_blank")
      )
    ),

    mainPanel(
      width = 9,

      tabsetPanel(
        tabPanel(
          "Visualization",
          br(),
          fluidRow(

            actionButton("add_knot_mode","Add knot",class = "btn-sm btn-primary",
              style = "background-color:#FFDD00; color:#000000"),
            actionButton("clear_manual_knots", "Clear \n manual knots", class = "btn-sm btn-danger"),

            actionButton("remove_knot", "Remove selected knot", class = "btn-sm btn-warning")
            ),


          h5("Selected Knot:"), column(4 ,verbatimTextOutput("selected_knot_display"),
          conditionalPanel(
            condition = "output.selected_knot_display != 'No knot selected'")),


          fluidRow(
            column(9, plotlyOutput("spline_plot", height = "600px")),

            column(
              3,
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
              ), # end constraints panel

              conditionalPanel(
                condition = "input.constraint_mode == 'region' && input.degree<6",
                div(style = "font-size: 13px; color: #555; margin-bottom: 10px;", "1. Click 'Select'"),
                div(style = "font-size: 13px; color: #555; margin-bottom: 10px;", "2. Select a region on the plot"),
                div(style = "font-size: 13px; color: #555; margin-bottom: 10px;", "3. X min/max fields are updated"),

                fluidRow(column(
                  6,
                  actionButton(
                    "start_selection",
                    "Select",
                    class = "btn-sm btn-warning",
                    style = "width:100%;"
                  )
                ), column(
                  6,
                  actionButton(
                    "clear_regions",
                    "Cancel region",
                    class = "btn-sm btn-danger",
                    style = "width:100%;"
                  )
                )),
                br(),

                fluidRow(column(
                  6, numericInput("region_xmin", "X min:", value = 0.3, step = 0.05)
                ), column(
                  6, numericInput("region_xmax", "X max:", value = 0.6, step = 0.05)
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
                  6,
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
                  6,
                  colourpicker::colourInput("curve_color", NULL, value = "blue")
                ),
                column(6, actionButton("apply_color", "Apply", class = "btn-sm"))
              ),

              p("Curves:", textOutput("curve_count", inline = TRUE)),


              fluidRow(column(4,actionButton("run", "Run", class = "btn-success btn-lg"),
                br(),
                actionButton("clear_all", "Clear all", class = "btn-sm btn-danger")),
                column(3,actionButton("clear_curves", "Clear last curve", class = "btn-sm btn-warning"),br(),
                actionButton("clear_all_curves", "Clear all curves", class = "btn-sm btn-danger")
              )))),

          br(),

          #MULTIPLICITY
          h5("Change Knot Multiplicity: (Multiplicity: m, Degree: d => minimum regularity at knot is C^{d-m}. C^{-1}:discontinuous) ",

             checkboxInput("consider_multiplicity_main","Consider Internal Multiplicities", value=TRUE )),
          h5("Warning: Degree=1 and any Multiplicity>1 cannot handle constraints"),
          column(8, actionButton("inc_multiplicity", "+", class = "btn-sm btn-primary"),
                 actionButton("dec_multiplicity", "-", class = "btn-sm btn-warning"),
                 actionButton("reset_multiplicity", "Reset multiplicity", class = "btn-sm btn-info")

          ),
          # Information (unique)
          fluidRow(
            column(6, h5("Information"), verbatimTextOutput("fit_info")),
            column(6, h5("List of knots"),
              verbatimTextOutput("knots_compact", placeholder = TRUE),
              h5("Coefficients on the Bspline Basis"),
              verbatimTextOutput("coeff_list", placeholder = TRUE)
              )

          ),



#=====================================================
# ============ AFFICHAGE DES COEFFICIENTS ============

fluidRow(
  column(
    12,
    checkboxInput("show_coefficients","Bspline basis polynomial coefficients display:",TRUE),
    conditionalPanel(
      condition = "input.show_coefficients",
    radioButtons(
      "local","",
      choices = c("Canonical (1, x, x²...)" = "FALSE",
                  "Local ((x-a)^i) for each knot a" = "TRUE"),
      selected = "TRUE",
      inline = TRUE
    ),
    verbatimTextOutput("bspline_coeff", placeholder = TRUE)
  )
))
,



# ============================================================
# SECTION 3 : DÉRIVÉES SUCCESSIVES
# ============================================================

fluidRow(
  column(12,
         h4("Derivatives", class = "text-primary"),

         # Boutons radio pour sélectionner les dérivées à afficher
         radioButtons(
           "deriv_display",
           "Display derivatives:",
           choices = c(
             "None" = "none",
             "1st derivative" = "1",
             "1st & 2nd" = "2",
             "1st, 2nd & 3rd" = "3"
           ),
           selected = "none",
           inline = TRUE
         )
  ),
uiOutput("derivatives_ui"))



    ),#end tab visualisation

# )#end tab derivatives
#

        tabPanel(
          "Data",
          br(),
          fluidRow(
            column(6, h4("Summary"), verbatimTextOutput("data_summary"))
            #,
            #column(6, h4("Knots"), verbatimTextOutput("knots_info"))
          ),
          br(),
          DTOutput("data_table")
        ),
        tabPanel(
          "Regions",
          br(),
          h4("Defined Regions"),
          verbatimTextOutput("regions_info"),
          br(),
          fluidRow(column(
            6, h5("Active regions"), uiOutput("regions_list_ui")
          ), column(
            6,
            h5("Instructions"),
            p("1. Mode 'Per region'"),
            p("2. 'Select' a rectangle on the plot"),
            p("3. Select constraints"),
            p("4. 'Add region'")
          ))
        ),
        tabPanel(
          "R Code",
          br(),
          h4("R Code to reproduce the analysis:"),
          verbatimTextOutput("r_code")
        ),



          tabPanel(
              "Basis",
              br(),
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

                  hr(),

                ),
                column(
                  9,
                  plotOutput("basis_plot", height = "600px", click = "basis_plot_click"),
                  br(),
                  h5("Basis Information"),
                  verbatimTextOutput("basis_info", placeholder = TRUE)
                )
              )
            ),
        tabPanel("Console", br(), fluidRow(column(
          12,
          div(
            style = "display: flex; justify-content: space-between; align-items: center; margin-bottom: 10px;",
            h4("Console Output", style = "margin: 0;"),
            actionButton(
              "clear_console",
              "Clear Console",
              icon = icon("eraser"),
              class = "btn-sm btn-danger"
            )
          ),
          div(
            style = "background-color: #1e1e1e; color: #d4d4d4; padding: 15px;
                 border-radius: 5px; font-family: 'Courier New', monospace;
                 font-size: 13px; height: 400px; overflow-y: auto;
                 white-space: pre-wrap; word-wrap: break-word;",
            verbatimTextOutput("console_output")
          )
        )))

,
tabPanel('Demo',br(),
         div(
           id = "demo_area",
           style = "display: none; margin-top: 10px;",
           hr(),
           h4("Demo Results:"),
           div(
             style = "overflow: auto; width: 100%; max-height: 1800px;",
             plotOutput("demo_plot", height = 800)  # Hauteur par défaut, sera modifiée dynamiquement
           ),
           br(),
           verbatimTextOutput("demo_output")
         )
)
      )
    )
  )
)
# .........................................................................
# ......................... SERVER -----------------------------------------
#..........................................................................

server <- function(input, output, session) {
  #Theme selector
  # Dans le server, ajoutez :
  observeEvent(input$toggle_theme, {
    # Basculer l'affichage de la zone de thème
    toggle("theme_selector_area", anim = TRUE)
  })

  # ============ REACTIVE VALUES ============
  values <- reactiveValues(
    xtab = NULL,
    ytab = NULL,
    knot = NULL,
    degree=3,
    multiplicity=NULL,
    manual_knot_multiplicity=NULL,
    auto_knot_count = 10,
    auto_knot_list= c(),
    manual_knot = c(),
    extended=vector(),
    adding_knot = FALSE,
    fitted = NULL,
    x_eval = NULL,
    y_eval = NULL,
    curve_lines = list(),
    regions = list(),
    data_name = "No data available",
    region_id = 0,
    selected_region_id = NULL,
    selecting_region = FALSE,
    derivatives = list(),
    consider_multiplicity=TRUE
  )


  # ============ CONSOLE ============

  console_messages <- reactiveVal("")

  log_console <- function(msg) {
    current <- console_messages()
    console_messages(paste0(current, msg, "\n"))
    cat(msg, "\n")  # Pour voir dans la console R aussi
  }

  # Observer pour vider la console
  observeEvent(input$clear_console, {
    console_messages("")
  })

  # Afficher la console
  output$console_output <- renderText({
    console_messages()
  })

  # ============ DATA GENERATION ============

#====================
# generate test_data
#====================

  observeEvent(input$test_data,test_data())

#=====================
# use temp data
#=====================
  observeEvent(input$temp_data,temp_data() )

#=====================
# generate custom data
#=====================
  observeEvent(input$generate_custom,
               generate_custom())


  # ============ KNOTS ============
  #===================================
  # manage knots
  #==================================



observeEvent(input$add_knot_mode, {
    values$adding_knot <- !values$adding_knot
    if (values$adding_knot) {
      showNotification("Add knot mode: click on the plot", type = "message")
      updateActionButton(session, "add_knot_mode", label = "Stop")
    } else {
      updateActionButton(session, "add_knot_mode", label = "Add knot")
    }
})


observeEvent( event_data("plotly_click", source = "plot"),
              {
                if (values$adding_knot) {
                  click <- event_data("plotly_click", source = "plot")
                  if (!is.null(click) && !is.null(values$xtab))
                  x<-click$x
                  add_knot(x)
                }
              }
              )


observeEvent(input$remove_knot,
             {
             idx <- selected_knot()
             remove_knot(idx)
             }
             )
#clear manual knots

observeEvent(input$clear_manual_knots,
             clear_manual_knot()
            )

# update the knot list on particular events


observeEvent(c(input$generate_custom,input$set_auto_knots),
               update_auto_knots(),
             ignoreNULL = TRUE, ignoreInit = FALSE)

#### Affiche des noeuds
output$knots_compact <- renderPrint({
    if (!is.null(values$knot) && length(values$knot) > 0) {
      k <- round(values$knot, 3)
      if (length(k) <= 15) {
        cat(paste(k, collapse = ", "))
      } else {
        cat(paste(c(head(k, 4), "...", tail(k, 4)), collapse = ", "))
      }
    } else {
      cat("(none)")
    }
  })

  #======================================================
  # ============ REGION SELECTION MANAGEMENT ============
  # =====================================================

observeEvent(input$start_selection, {
    values$selecting_region <- !values$selecting_region
    if (values$selecting_region) {
      showNotification("Select a region on the plot (rectangle)", type = "message")
      updateActionButton(session, "start_selection", label = "Stop")
    } else {
      updateActionButton(session, "start_selection", label = "Select")
    }
  })

observeEvent(event_data("plotly_selected", source = "plot"), {
    if (input$constraint_mode == "region" && values$selecting_region) {
      selected <- event_data("plotly_selected", source = "plot")
      if (!is.null(selected)) if( nrow(selected) > 0) {
        x_vals <- selected$x
        if (length(x_vals) >= 2) {
          xmin <- min(x_vals, na.rm = TRUE)
          xmax <- max(x_vals, na.rm = TRUE)
          updateNumericInput(session, "region_xmin", value = round(xmin, 3))
          updateNumericInput(session, "region_xmax", value = round(xmax, 3))
          values$selecting_region <- FALSE
          updateActionButton(session, "start_selection", label = "Select")
          showNotification(paste(
            "Region selected: [",
            round(xmin, 3),
            ", ",
            round(xmax, 3),
            "]"
          ),
          type = "message")
        }
      }
    }
  })


observeEvent(input$add_region, {
    req(values$xtab, values$knot)
    xmin <- input$region_xmin
    xmax <- input$region_xmax
    if (xmin >= xmax) {
      showNotification("X min < X max", type = "warning")
      return()
    }
    values$region_id <- values$region_id + 1
    region <- list(
      id = values$region_id,
      xmin = xmin,
      xmax = xmax,
      monot = as.numeric(input$region_monot),
      conv = as.numeric(input$region_conv),
      der3 = as.numeric(input$region_der3)
    )
    values$regions <- c(values$regions, list(region))
    values$selected_region_id <- NULL
    showNotification(paste("Region added: [", round(xmin, 3), ", ", round(xmax, 3), "]"), type = "message")
  })

  # observeEvent(input$update_region, {
  #   if (!is.null(values$selected_region_id)) {
  #     idx <- which(sapply(values$regions, function(r)
  #       r$id == values$selected_region_id))
  #     if (length(idx) > 0) {
  #       values$regions[[idx]]$xmin <- input$region_xmin
  #       values$regions[[idx]]$xmax <- input$region_xmax
  #       values$regions[[idx]]$monot <- as.numeric(input$region_monot)
  #       values$regions[[idx]]$conv <- as.numeric(input$region_conv)
  #       values$regions[[idx]]$der3 <- as.numeric(input$region_der3)
  #       showNotification("Region updated", type = "message")
  #     }
  #   } else {
  #     showNotification("Select a region first", type = "warning")
  #   }
  # })

  observeEvent(input$clear_regions, {
    values$regions <- c()
    values$region_id <- 0
    values$selected_region_id <- NULL
    showNotification("All regions cleared", type = "message")
  })


  observeEvent(input$delete_region, {
    id <- as.numeric(input$delete_region)
    if (is.na(id)) {
      showNotification("Invalid ID", type = "warning")
      return()
    }
    values$regions <- values$regions[!sapply(values$regions, function(r)
      r$id == id)]
    if (!is.null(values$selected_region_id) &&
        values$selected_region_id == id) {
      values$selected_region_id <- NULL
    }
    showNotification(paste("Region", id, "deleted"), type = "message")
  }, ignoreNULL = TRUE)



  observeEvent(input$load_csv, load_csv() )



  observeEvent(input$load_excel, load_excel() )


  # ============ REGRESSION ============

  observeEvent(input$run, run_regression())



  # ============ VISUALIZATION ============
output$spline_plot <- renderPlotly({
    req(values$xtab, values$ytab)

    p <- plot_ly(source = "plot")

    # Data display
    p <- p %>% add_trace(
      x = values$xtab,
      y = values$ytab,
      type = "scatter",
      mode = "markers",
      marker = list(color = "gray", size = 6, opacity = 0.5),
      name = "Data"
    )

    # Dans le plot de visualisation, afficher les multiplicités
    if (!is.null(values$knot)) {
      y_range <- range(values$ytab, na.rm = TRUE)
      y_pos <- y_range[2] - 0.1 * diff(y_range)
      l <- length(values$knot)
      for (i in 1:l) {
        mult <- values$knot_multiplicity[i]

        # Couleur selon multiplicité
        color <- switch(as.character(mult),
                        "1" = "blue",
                        "2" = "orange",
                        "3" = "red",
                        "4" = "darkred",
                        "gray")

        # Symbole selon multiplicité
        symbol <- switch(as.character(mult),
                         "1" = "circle",
                         "2" = "square",
                         "3" = "diamond",
                         "4" = "cross",
                         "circle")

        p <- p %>% add_trace(
          x = values$knot[i],
          y = y_pos,
          type = "scatter",
          mode = "markers+text",
          marker = list(color = color, symbol = symbol, size = 12),
          text = paste0("m=", mult),
          textposition = "top center",
          textfont = list(size = 8, color = "black"),
          name = "Knots",
          showlegend = FALSE
        )
      }
    }

    # Knots
    if (!is.null(values$knot) && length(values$knot) > 0) {
      y_range <- range(values$ytab, na.rm = TRUE)
      y_pos <- y_range[2] - 0.1 * diff(y_range)

      p <- p %>% add_trace(
        x = values$knot,
        y = rep(y_pos, length(values$knot)),
        type = "scatter",
        mode = "markers",
        marker = list(color = "red", symbol = "triangle-down", size = 10),
        name = "Knots"
      )

      # Ajouter le marqueur du nœud sélectionné
      idx <- selected_knot()
      if (!is.null(idx) && idx >= 1 && idx <= length(values$knot)) {
        p <- p %>% add_trace(
          x = values$knot[idx],
          y = y_pos,
          type = "scatter",
          mode = "markers",
          marker = list(color = "green", symbol = "circle", size = 20, opacity = 0.7),
          name = "Selected Knot"
        )
      }
    }

    # Regions
    if (input$constraint_mode == "region" && length(values$regions) > 0) {
      y_range <- range(values$ytab, na.rm = TRUE)
      for (region in values$regions) {
        is_selected <- !is.null(values$selected_region_id) && values$selected_region_id == region$id
        border_color <- if (is_selected) "#ff0000" else "rgba(255, 152, 0, 0.8)"
        fill_color <- if (is_selected) "rgba(255, 0, 0, 0.15)" else "rgba(255, 152, 0, 0.15)"
        p <- p %>% add_trace(
          x = c(region$xmin, region$xmax, region$xmax, region$xmin, region$xmin),
          y = c(y_range[1], y_range[1], y_range[2], y_range[2], y_range[1]),
          type = "scatter",
          mode = "lines",
          fill = "toself",
          fillcolor = fill_color,
          line = list(color = border_color, width = ifelse(is_selected, 3, 1)),
          name = paste0("Region ", region$id),
          hoverinfo = "text",
          text = paste0(
            "Region ", region$id, "\n",
            "[", round(region$xmin, 3), ", ", round(region$xmax, 3), "]\n",
            "M: ", get_sym(region$monot, c("down", "x", "up")), "\n",
            "C: ", get_sym(region$conv, c("n", "x", "U")), "\n",
            "D3: ", get_sym(region$der3, c("-", "x", "+"))
          )
        )
      }
    }

    # Curves
    for (curve in values$curve_lines) {
      if (!is.null(curve$x) && !is.null(curve$y)) {
        p <- p %>% add_trace(
          x = curve$x,
          y = curve$y,
          type = "scatter",
          mode = "lines",
          line = list(color = curve$color, width = 2),
          name = paste0("tau=", input$tau)
        )
      }
    }

    # Layout
    p <- p %>% layout(
      annotations = list(
        x = 0.02,
        y = 0.98,
        text = paste("Knots:", length(values$knot %||% numeric(0))),
        xref = "paper",
        yref = "paper",
        showarrow = FALSE,
        font = list(size = 12, color = "red")
      ),
      xaxis = list(title = "x"),
      yaxis = list(title = "y"),
      hovermode = "closest",
      legend = list(orientation = "h", y = -0.1),
      dragmode = if (values$selecting_region && input$constraint_mode == "region") "select" else "zoom"
    )

    # ============================================================
    ## ENREGISTREMENT DES ÉVÉNEMENTS
    # ============================================================
    p <- p %>%
      event_register("plotly_click") %>%
      event_register("plotly_selected")

    # Config
    p <- p %>% config(
      scrollZoom = TRUE,
      displaylogo = FALSE,
      modeBarButtonsToRemove = c("sendDataToCloud", "resetViews")
    )

    p
  })

  # ============ KNOT SELECTION FROM VISUALIZATION ============

  # Reactive value pour le nœud sélectionné
  selected_knot <- reactiveVal(NULL)

  # Observer les clics sur le plot principal

  observeEvent(event_data("plotly_click", source = "plot"),
               {
    click <- event_data("plotly_click", source = "plot")

    if (!is.null(click) && !is.null(values$knot)) {
      x <- click$x
      idx<-select_knot(x)
      selected_knot(idx)

    }
               }
    )




  # Afficher le nœud sélectionné
  output$selected_knot_display <- renderPrint({
    idx <- selected_knot()
    if (!is.null(idx) && !is.null(values$knot)) {
      cat("  Index:", idx,".")
      cat("  Value:", round(values$knot[idx], 4))
    } else {
      cat("No knot selected\n")
      cat("Click on a knot in the plot to select it.")
    }
  })
    # ============ REGION SELECTION BY CLICK ============

  observeEvent(event_data("plotly_click", source = "plot"), {
      if (!values$selecting_region && input$constraint_mode == "region") {
        click <- event_data("plotly_click", source = "plot")
        if (!is.null(click)) {
          x <- click$x
          for (region in values$regions) {
            if (x >= region$xmin && x <= region$xmax) {
              values$selected_region_id <- region$id
              update_region_fields(region$xmin, region$xmax)
              updateRadioButtons(session, "region_monot", selected = as.character(region$monot))
              updateRadioButtons(session, "region_conv", selected = as.character(region$conv))
              updateRadioButtons(session, "region_der3", selected = as.character(region$der3))
              showNotification(paste("Region", region$id, "selected"), type = "message")
              break
            }
          }
        }
      }

    })



    # ============ OUTPUTS ============
    # = INFO = COEFF
    output$coeff_list<- renderPrint( {
      tryCatch({
        if (is.null(values$fitted)) {
          return('No regression')
        } else
        {
          # Extraire les informations
            list_coeff <- (get_parameters(values$fitted))$coeff
            status <- (get_parameters(values$fitted))$result$status
            cat("Status of convergence: ",status,"\n")
            cat("Number (dimension of the basis): ",
                length(list_coeff %||% numeric(0)), "\n")
            cat("Values: \n")
            cat(list_coeff)
            }},
        error = function(e) {
          cat("Error displaying fit info:", e$message)
        })
    })

   #===INFO==GENERAL
  output$fit_info <- renderPrint(
        {
          tryCatch({
            if (!is.null(values$fitted))cat("Solver: ",input$solver," mean result value:",(get_parameters(values$fitted)$result$value)/length(values$xtab), "\n")

        cat("Degree:", if (!is.na(values$degree))
            values$degree
            else
              "unknown", "   ")
        cat("Tau:", input$tau, "   ")
        cat("Knots:", if (!is.na(values$degree)){length(values$knot)}
              else{"Unknown" }, "\n")
            }

      , error = function(e) {
        cat("Error displaying info:", e$message)}
        )
      constraints <- build_constraints()
      cat("Constraints:\n",
        "Monotone",paste(c(constraints$monot), collapse = ",") ,'\n',
          "Convex",paste(c(constraints$conv),collapse = ",") , "\n",
          "Third derivative",paste( c(constraints$der3),collapse = ",") , "\n"
    )
    } )
    output$knot_list_display <- renderPrint({
      if (is.null(values$knot)) {
        cat("No knots defined")
      } else {
        cat("All knots:\n")
        for (i in seq_along(values$knot)) {
          cat(sprintf("  [%d] %.4f\n", i, values$knot[i]))
        }
      }
    })
  # = Curve cournt =
  output$curve_count <- renderText({
    length(values$curve_lines)
  })

# regions
output$regions_list_ui <- renderUI({
    if (length(values$regions) == 0) {
      return(p("No regions", style = "color: #999;"))
    }
    tags$div(lapply(values$regions, function(r) {
      is_selected <- !is.null(values$selected_region_id) &&
        values$selected_region_id == r$id
      tags$div(
        class = "region-box",
        style = if (is_selected)
          "border: 3px solid #ff0000; background-color: rgba(255,0,0,0.1);",
        tags$div(
          style = "display: flex; justify-content: space-between;",
          tags$span(
            style = "font-weight: bold;",
            paste0(
              "Region ",
              r$id,
              " [",
              round(r$xmin, 3),
              ", ",
              round(r$xmax, 3),
              "]"
            )
          ),
          actionButton(
            paste0("del_", r$id),
            "x",
            class = "btn-sm btn-danger",
            style = "padding: 0px 6px;",
            onclick = paste0("Shiny.setInputValue('delete_region', ", r$id, ")")
          )
        ),
        tags$div(
          style = "font-size: 12px; color: #555;",
          paste0(
            "M: ",
            get_sym(r$monot, c("down", "x", "up")),
            " | C: ",
            get_sym(r$conv, c("n", "x", "U")),
            " | D3: ",
            get_sym(r$der3, c("-", "x", "+"))
          )
        )
      )
    }))
  })

  #============= bspline coefficients ======================
  output$bspline_coeff<-renderPrint(
    {if (is.null(values$fitted)){return("No regression")}
      else{
        return(
          show_pp(values$fitted,local=input$local,verbose=input$verbose)
        )

      }
    }
  )

  # ============================================================================
  # UI POUR LES DÉRIVÉES
  # ============================================================================

  output$derivatives_ui <- renderUI({
    req(values$fitted)

    selected <- input$deriv_display
    if (selected == "none") {
      return(NULL)
    }

    n_deriv <- as.numeric(selected)
    plot_list <- list()

    for (d in 1:n_deriv) {
      # Nom de la dérivée
      deriv_names <- c("1st derivative", "2nd derivative", "3rd derivative")

      # Créer la ligne avec le plot et les coefficients
      plot_list[[d]] <- fluidRow(
        column(6,
               plotlyOutput(paste0("deriv_plot_", d), height = "250px")
        ),
        column(6,
               h5(paste("Coefficients of", deriv_names[d])),
               verbatimTextOutput(paste0("deriv_coeff_", d))
        )
      )

      # Ajouter un séparateur
      if (d < n_deriv) {
        plot_list[[d]] <- tagList(plot_list[[d]], hr())
      }
    }

    do.call(tagList, plot_list)
  })


  observe({
    plot_derivatives()

    display_derivatives()}
    ) # end observe






####============DATA
  output$data_summary <- renderPrint({
    if (is.null(values$xtab)) {
      cat("No data")
    } else {
      cat("Source:", values$data_name, "\n")
      cat("Points:", length(values$xtab), "\n")
      cat("x: [", min(values$xtab), ",", max(values$xtab), "]\n")
      cat("y: [", min(values$ytab), ",", max(values$ytab), "]")
    }
  })

  output$knots_info <- renderPrint({
    if (is.null(values$knot)) {
      cat("No knots")
    } else {
      cat("Knots:", length(values$knot), "\n")
      print(round(values$knot, 4))
    }
  })

  output$data_table <- renderDT({
    if (is.null(values$xtab))
      return(NULL)
    datatable(data.frame(
      x = round(values$xtab, 4),
      y = round(values$ytab, 4)
    ),
    options = list(pageLength = 10, scrollX = TRUE))
  })

  output$regions_info <- renderPrint({
    if (length(values$regions) == 0) {
      cat("No regions")
    } else {
      for (r in values$regions) {
        cat(
          r$id,
          ": [",
          round(r$xmin, 3),
          ", ",
          round(r$xmax, 3),
          "]  ",
          "M=",
          get_sym(r$monot, c("down", "x", "up")),
          " C=",
          get_sym(r$conv, c("n", "x", "U")),
          " D3=",
          get_sym(r$der3, c("-", "x", "+")),
          "\n",
          sep = ""
        )
      }
    }
  })
  #=================================
  # ============ R CODE ============
  #=================================

  output$r_code <- renderText(make_r_code())

  # ============ ACTIONS on CURVES ============

  observeEvent(input$apply_color, {
    showNotification(paste("Color:", input$curve_color), type = "message")
  })

  observeEvent(input$clear_all_curves, {
    values$curve_lines <- list()
    showNotification("All curves cleared", type = "message")
  })

  observeEvent(input$clear_curves, {
    ncurves<-length(values$curve_lines)
    values$curve_lines[ncurves] <- NULL
    showNotification("Last curve cleared", type = "message")
  })

  observeEvent(input$clear_all, {
    values$xtab <- NULL
    values$ytab <- NULL
    values$knot <- NULL
    values$fitted <- NULL
    values$curve_lines <- list()
    values$regions <- list()
    values$region_id <- 0
    values$selected_region_id <- NULL
    values$data_name <- "No data"
    showNotification("All cleared", type = "message")
  })


  # ==========================================
  # ============ DEMOS DU PACKAGE ============

  demo_results <- reactiveValues(plot = NULL,
                                 output = NULL,
                                 height = 800)
  demo_heights <- list(
    comprehensive = 800,
    monotonicity = 800,
    logistic = 800,
    temperature = 800,
    temperature2 = 800,
    convexity = 800,
    degrees_comparison = 800,
    demo_der3 = 800,
    derivative2 = 1800
  )


  #========== Demo Execution ==============

  observeEvent(input$demo_comp, {
    execute_demo("comprehensive")
  })
  observeEvent(input$demo_monot, {
    execute_demo("monotonicity_basic")
  })
  observeEvent(input$demo_log, {
    execute_demo("logistic")
  })
  observeEvent(input$demo_temp, {
    execute_demo("temperature")
  })
  observeEvent(input$demo_temp2, {
    execute_demo("temperature2")
  })
  observeEvent(input$demo_conv, {
    execute_demo("convexity")
  })
  observeEvent(input$demo_degrees, {
    execute_demo("degrees_comparison")
  })
  observeEvent(input$demo_der3, {
    execute_demo("demo_der3")
  })
  observeEvent(input$demo_derivative, {
    execute_demo("derivative2")
  })

  # Afficher les résultats
  output$demo_plot <- renderPlot({
    if (!is.null(demo_results$plot)) {
      grid::grid.draw(demo_results$plot)
    }
  })

  output$demo_output <- renderPrint({
    if (!is.null(demo_results$output)) {
      cat(paste(demo_results$output, collapse = "\n"))
    }
  })




################VIEW BASIS
  # ============ BASIS ============
  basis_values <- reactiveValues(
    basis_obj = NULL,
    der_basis_obj = NULL,
    x_eval = NULL,
    y_eval = NULL,
    derivative=0
  )

  observeEvent(input$basis_update, basis_update())


   output$basis_info <- renderPrint({
    req(basis_values$der_basis_obj)

    obj <- basis_values$der_basis_obj
    cat("B-spline Basis Information\n")
    cat("==========================\n")
    cat("Degree:", obj$degree)
    cat(" (Original degree:", values$degree,")\n")
    cat("Derivative order:", input$basis_derivative, "\n")
    cat("Number of basis functions:", obj$n_splines, "\n")
    cat("Number of knots:", length(values$knot), "\n")
  })

  output$multiplicity_info <- renderPrint({
    if (!is.null(values$knot)) {
        cat("Knot multiplicities:\n")
      l=length(values$knot)
      for (i in 1:l) {
        cat(sprintf("  %.4f: m=%d\n", values$knot[i], values$knot_multiplicity[i]))
      }
    } else {
      cat("No knots defined")
    }
  })

  # Dans le plot de la base
  output$basis_plot <- renderPlot({
    req(basis_values$der_basis_obj, basis_values$x_eval)

    # Utiliser view_basis
    x_values<-basis_values$x_eval
    view_basis(
      basis_values$der_basis_obj,
      x_values = x_values,
      view_knot = input$basis_show_knots
    )

    # Ajouter les multiplicités manuellement
    if (input$basis_show_knots && !is.null(values$knot)) {
      y_range <- par("usr")[3:4]
      y_pos <- y_range[1] + 0.02 * diff(y_range)
      l=length(values$knot)
      for (i in 1:l) {
        mult <- values$knot_multiplicity[i]
        if (mult > 0) {
          text(values$knot[i], y_pos, if (input$basis_show_multiplicity){
               labels = paste0("m=", mult)}else{""},
               col = "blue", cex = 0.7, srt = 90, adj = 0)
        }
      }
    }
  })



# ============ MULTIPLICITY CONTROL ============

  observeEvent(input$consider_multiplicity, {
    values$consider_multiplicity <- input$consider_multiplicity
    updateCheckboxInput(session, "consider_multiplicity_main",
                        value = input$consider_multiplicity)
  })

  # Synchronisation : Main → Basis
  observeEvent(input$consider_multiplicity_main, {
    values$consider_multiplicity <- input$consider_multiplicity_main
    updateCheckboxInput(session, "consider_multiplicity",
                        value = input$consider_multiplicity_main)
  })

# Initialisation (au démarrage)
  observe({
    # Mettre à jour les deux checkbox avec la valeur initiale
    updateCheckboxInput(session, "consider_multiplicity_basis",
                        value = values$consider_multiplicity)
    updateCheckboxInput(session, "consider_multiplicity_main",
                        value = values$consider_multiplicity)

  })



# Augmenter la multiplicité
observeEvent(input$inc_multiplicity,inc_multiplicity() )

# Diminuer la multiplicité
observeEvent(input$dec_multiplicity,dec_multiplicity()() )

# #update knots multiplicities

observeEvent(input$degree,update_knot_multiplicity_1())

#reset la multiplicite
observeEvent(input$reset_multiplicity, {
  reset_multiplicity()
})



#====================================================
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


#=============================================================
# ============  source all functions =========================
#=============================================================

source('./knot_mult_const.R',local=TRUE)
source('./runregression_export_r.R',local=TRUE)
source('./basis_derivative.R',local=TRUE)
source('./data_generate_import.R',local=TRUE)

#=============================================================
#                     END OF FUNCTION SECTION
#-------------------------------------------------------------
#=============================================================


}# End server()

# Run app
shinyApp(ui = ui, server = server)
