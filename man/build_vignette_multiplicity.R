  app <- AppDriver$new(test_path("../../inst/shiny/app2"), variant = platform_variant(),
                       name = "test_change_multiplicity", height = 752, width = 1139)

  app$click("generate_custom")
  app$set_inputs(auto_knot_count = 5)
  app$click("test_data")
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":0,\"pointNumber\":110,\"x\":0.5527638190954774,\"y\":1.3033950199219326}]",
                 allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = character(0), allow_no_input_binding_ = TRUE,
                 priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":0,\"pointNumber\":146,\"x\":0.7336683417085427,\"y\":1.3825676902317734}]",
                 allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = character(0), allow_no_input_binding_ = TRUE,
                 priority_ = "event")

  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":3,\"pointNumber\":0,\"x\":0.5,\"y\":1.9266990699324613}]",
                 allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = character(0), allow_no_input_binding_ = TRUE,
                 priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":6,\"pointNumber\":2,\"x\":0.5,\"y\":1.9266990699324613}]",
                 allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_click-plot` = "[{\"curveNumber\":6,\"pointNumber\":2,\"x\":0.5,\"y\":1.9266990699324613}]",
                 allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":7,\"pointNumber\":0,\"x\":0.5,\"y\":1.9266990699324613}]",
                 allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = character(0), allow_no_input_binding_ = TRUE,
                 priority_ = "event")
  app$set_inputs(`plotly_afterplot-plot` = "\"spline_plot\"", allow_no_input_binding_ = TRUE,
                 priority_ = "event")
  app$set_inputs(`plotly_relayout-plot` = "{\"xaxis.range[0]\":-0.7664666036009908,\"xaxis.range[1]\":1.0930259854242408,\"yaxis.range[0]\":-1.127106796055367,\"yaxis.range[1]\":4.099345617756454}",
                 allow_no_input_binding_ = TRUE, priority_ = "event")
  app$click("inc_multiplicity")
  app$click("inc_multiplicity")
  app$click("inc_multiplicity")
  app$wait_for_idle(timeout = 60000)
  app$set_inputs(`plotly_afterplot-plot` = "\"spline_plot\"", allow_no_input_binding_ = TRUE,
                 priority_ = "event")
  app$set_inputs(`plotly_relayout-plot` = "{\"xaxis.range[0]\":-0.4397784898906473,\"xaxis.range[1]\":1.312458266972107,\"yaxis.range[0]\":-1.9489694980664063,\"yaxis.range[1]\":2.9760202983574953}",
                 allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_afterplot-plot` = "\"spline_plot\"", allow_no_input_binding_ = TRUE,
                 priority_ = "event")
  app$set_inputs(`plotly_relayout-plot` = "{\"xaxis.range[0]\":0.34365223905713876,\"xaxis.range[1]\":0.8021974632495361,\"yaxis.range[0]\":-1.9489694980664063,\"yaxis.range[1]\":2.9760202983574953}",
                 allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_afterplot-plot` = "\"spline_plot\"", allow_no_input_binding_ = TRUE,
                 priority_ = "event")
  app$set_inputs(`plotly_relayout-plot` = "{\"xaxis.range[0]\":-0.32207425280563406,\"xaxis.range[1]\":1.2357956388706839,\"yaxis.range[0]\":-1.5887219230718017,\"yaxis.range[1]\":2.78996337194443}",
                 allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_afterplot-plot` = "\"spline_plot\"", allow_no_input_binding_ = TRUE,
                 priority_ = "event")
  app$set_inputs(`plotly_relayout-plot` = "{\"xaxis.range[0]\":0.3580853588235119,\"xaxis.range[1]\":0.7930818086602478,\"yaxis.range[0]\":-1.9489694980664063,\"yaxis.range[1]\":2.9760202983574953}",
                 allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_afterplot-plot` = "\"spline_plot\"", allow_no_input_binding_ = TRUE,
                 priority_ = "event")
  app$set_inputs(`plotly_relayout-plot` = "{\"xaxis.range[0]\":0.37161361170086843,\"xaxis.range[1]\":0.7842706439572327,\"yaxis.range[0]\":-1.7821842036823603,\"yaxis.range[1]\":2.8898807615557316}",
                 allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":0,\"pointNumber\":124,\"x\":0.6231155778894473,\"y\":1.4320351375914415}]",
                 allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = character(0), allow_no_input_binding_ = TRUE,
                 priority_ = "event")

  #app$click("run")
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":0,\"pointNumber\":97,\"x\":0.48743718592964824,\"y\":0.7900854722233761}]",
                 allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = character(0), allow_no_input_binding_ = TRUE,
                 priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":0,\"pointNumber\":91,\"x\":0.457286432160804,\"y\":0.8252831003499348}]",
                 allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = character(0), allow_no_input_binding_ = TRUE,
                 priority_ = "event")

  app$set_inputs(main_tabs = "Basis")
  app$click("basis_update")

  app$wait_for_idle(timeout = 50000)  # Attendre plus longtemps
  app$get_screenshot("man/figures/basis1.png", selector = "viewport")
  app$set_inputs(basis_plot_click = character(0), allow_no_input_binding_ = TRUE)
#  app$expect_screenshot()
  #app$set_inputs(monot = "1")
  #app$expect_screenshot()
  #app$click("run")
  #app$set_inputs(curve_color = "#4C4C57")
  #app$click("run")
  #app$expect_screenshot()
  app$set_inputs(main_tabs = "Visualization")
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":4,\"pointNumber\":0,\"x\":0.75,\"y\":1.9266990699324613}]",
                 allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_click-plot` = "[{\"curveNumber\":4,\"pointNumber\":0,\"x\":0.75,\"y\":1.9266990699324613}]",
                 allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":7,\"pointNumber\":0,\"x\":0.75,\"y\":1.9266990699324613}]",
                 allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = character(0), allow_no_input_binding_ = TRUE,
                 priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":0,\"pointNumber\":174,\"x\":0.8743718592964824,\"y\":2.2124452080540964}]",
                 allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_afterplot-plot` = "\"spline_plot\"", allow_no_input_binding_ = TRUE,
                 priority_ = "event")
  app$set_inputs(`plotly_relayout-plot` = "{\"xaxis.range[0]\":-1.836668970698044,\"xaxis.range[1]\":1.4086688221103523,\"yaxis.range[0]\":-6.4282666153624595,\"yaxis.range[1]\":2.6991110171356025}",
                 allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_afterplot-plot` = "\"spline_plot\"", allow_no_input_binding_ = TRUE,
                 priority_ = "event")
  app$set_inputs(`plotly_relayout-plot` = "{\"xaxis.range[0]\":-0.19517083802938395,\"xaxis.range[1]\":1.0974843419835925,\"yaxis.range[0]\":-1.2152190860371248,\"yaxis.range[1]\":2.4203198716419667}",
                 allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = character(0), allow_no_input_binding_ = TRUE,
                 priority_ = "event")
  app$click("inc_multiplicity")
  app$click("inc_multiplicity")
  app$wait_for_idle(timeout = 30000)  # Attendre plus longtemps

  #app$click("run")
  #app$click("clear_all_curves")
  #app$click("run")
  #app$expect_screenshot()
  app$set_inputs(main_tabs = "Basis")
  app$click("basis_update")
  app$wait_for_idle(timeout = 30000)  # Attendre plus longtemps
  app$get_screenshot("man/figures/basis2.png", selector = "viewport")


  app$set_inputs(basis_derivative = 1)
  app$click("basis_update")
  app$get_screenshot("man/figures/basis3.png", selector = "viewport")
  app$set_inputs(basis_derivative = 2)
  app$click("basis_update")
  app$get_screenshot("man/figures/basis4.png", selector = "viewport")

  app$set_inputs(basis_derivative = 3)
  app$click("basis_update")
  app$get_screenshot("man/figures/basis5.png", selector = "viewport")



  #reset multiplicities


  app$set_inputs(main_tabs = "Visualization")
  app$set_inputs(consider_multiplicity = FALSE)
#  app$click("Consider_multiplicity_main")
  app$click("run")


  app$wait_for_idle(timeout = 30000)

  app$get_screenshot("man/figures/basis6.png",selector="viewport")

  app$set_inputs(main_tabs = "Basis")
  app$set_inputs(basis_derivative = 0)
#    app$click("basis_update")
  app$click("basis_update")
  app$wait_for_idle(timeout = 30000)  # Attendre plus longtemps
  app$get_screenshot("man/figures/basis7.png", selector = "viewport")



    app$stop()
