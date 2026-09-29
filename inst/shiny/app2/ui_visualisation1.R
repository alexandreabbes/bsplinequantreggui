ui_visualisationtab1<-function()
{
fluidRow(
  actionButton("add_knot_mode","Add knot",class = "btn-sm btn-primary",
               style = "background-color:#FFDD00; color:#000000"),
  actionButton("clear_manual_knots", "Clear \n manual knots", class = "btn-sm btn-danger"),

  actionButton("remove_knot", "Remove selected knot", class = "btn-sm btn-warning"),

  h5("Selected Knot:"), column(4 ,verbatimTextOutput("selected_knot_display"),
                               conditionalPanel(
                                 condition = "output.selected_knot_display != 'No knot selected'")),


  column(9, plotlyOutput("spline_plot", height = "600px"),


         br(),
         #MULTIPLICITY
         h5("Change Knot Multiplicity: (Multiplicity: m, Degree: d => minimum regularity at knot is C^{d-m}. C^{-1}:discontinuous) ",

            checkboxInput("consider_multiplicity_main","Consider Internal Multiplicities", value=TRUE )),
         h5("Warning: Degree=1 and any Multiplicity>1 cannot handle constraints"),
         column(8, actionButton("inc_multiplicity", "+", class = "btn-sm btn-primary"),
                actionButton("dec_multiplicity", "-", class = "btn-sm btn-warning"),
                # Information (unique)
                fluidRow(
                  column(6, h5("Information"), verbatimTextOutput("fit_info")),
                  column(6, h5("List of knots / multiplicities"),
                         verbatimTextOutput("knots_compact", placeholder = TRUE),
                         h5("Coefficients on the Bspline Basis"),
                         verbatimTextOutput("coeff_list", placeholder = TRUE)
                  )

                ),
         ), #end modify mult
         #=====================================================
         # ============ AFFICHAGE DES COEFFICIENTS ============

         fluidRow(
           column(
             9,
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
           )) ,



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
           uiOutput("derivatives_ui") #end tab derivatives

         ))

)
}
