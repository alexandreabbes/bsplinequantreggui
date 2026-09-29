
fluidRow(
  column(6, h4("Summary"), verbatimTextOutput("data_summary")),
  #,
  column(6, h4("Knots"), verbatimTextOutput("knots_info"))
),
br(),
DTOutput("data_table")
