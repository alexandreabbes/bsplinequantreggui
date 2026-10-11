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


