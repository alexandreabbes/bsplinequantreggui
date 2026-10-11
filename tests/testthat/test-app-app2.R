library(shinytest2)

test_that("{shinytest2} recording: app2", {
  local_app_support(test_path("../../inst/shiny/app2"))
  app <- AppDriver$new(test_path("../../inst/shiny/app2"), variant = platform_variant(), 
      name = "app2", height = 752, width = 1139)
  app$expect_screenshot()
  app$click("test_data")
  app$expect_screenshot()
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":0,\"pointNumber\":174,\"x\":0.8743718592964824,\"y\":2.2124452080540964}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = character(0), allow_no_input_binding_ = TRUE, 
      priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":0,\"pointNumber\":97,\"x\":0.48743718592964824,\"y\":0.7900854722233761}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = character(0), allow_no_input_binding_ = TRUE, 
      priority_ = "event")
  app$click("run")
  app$expect_screenshot()
  app$set_inputs(monot = "1")
  app$click("run")
  app$click("clear_all_curves")
  app$click("run")
  app$expect_screenshot()
})


test_that("{shinytest2} recording: test_init", {
  local_app_support(test_path("../../inst/shiny/app2"))
  app <- AppDriver$new(test_path("../../inst/shiny/app2"), variant = platform_variant(), 
      name = "test_init", height = 752, width = 1139)
  app$expect_screenshot()
  app$click("test_data")
  app$expect_screenshot()
  app$click("run")
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":0,\"pointNumber\":196,\"x\":0.9849246231155779,\"y\":1.7171355839708766}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = character(0), allow_no_input_binding_ = TRUE, 
      priority_ = "event")
  app$expect_screenshot()
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":0,\"pointNumber\":171,\"x\":0.8592964824120604,\"y\":2.1885963257320666}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = character(0), allow_no_input_binding_ = TRUE, 
      priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":0,\"pointNumber\":199,\"x\":1,\"y\":1.5815660563544272}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = character(0), allow_no_input_binding_ = TRUE, 
      priority_ = "event")
  app$set_inputs(monot = "1")
  app$click("run")
  app$expect_screenshot()
  app$click("clear_all_curves")
  app$click("run")
  app$expect_screenshot()
  app$set_inputs(constraint_mode = "region")
  app$click("start_selection")
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":12,\"pointNumber\":250,\"x\":0.8361204013377926,\"y\":1.692215712124194}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = character(0), allow_no_input_binding_ = TRUE, 
      priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":0,\"pointNumber\":157,\"x\":0.7889447236180904,\"y\":1.5602504193107243}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = character(0), allow_no_input_binding_ = TRUE, 
      priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":0,\"pointNumber\":134,\"x\":0.6733668341708543,\"y\":1.6135492789127472}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = character(0), allow_no_input_binding_ = TRUE, 
      priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":0,\"pointNumber\":125,\"x\":0.628140703517588,\"y\":1.529282421254051}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = character(0), allow_no_input_binding_ = TRUE, 
      priority_ = "event")
  app$set_inputs(region_monot = "1")
  app$expect_screenshot()
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":9,\"pointNumber\":0,\"x\":0.8888888888888888,\"y\":1.9266990699324613}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = character(0), allow_no_input_binding_ = TRUE, 
      priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":12,\"pointNumber\":258,\"x\":0.862876254180602,\"y\":1.8164339936578182}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = character(0), allow_no_input_binding_ = TRUE, 
      priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":0,\"pointNumber\":137,\"x\":0.6884422110552764,\"y\":1.7192698305263345}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = character(0), allow_no_input_binding_ = TRUE, 
      priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":0,\"pointNumber\":134,\"x\":0.6733668341708543,\"y\":1.6135492789127472}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = character(0), allow_no_input_binding_ = TRUE, 
      priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":0,\"pointNumber\":125,\"x\":0.628140703517588,\"y\":1.529282421254051}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = character(0), allow_no_input_binding_ = TRUE, 
      priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":6,\"pointNumber\":0,\"x\":0.5555555555555556,\"y\":1.9266990699324613}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = character(0), allow_no_input_binding_ = TRUE, 
      priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":5,\"pointNumber\":0,\"x\":0.4444444444444444,\"y\":1.9266990699324613}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = character(0), allow_no_input_binding_ = TRUE, 
      priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":0,\"pointNumber\":185,\"x\":0.9296482412060302,\"y\":1.340035690899476}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = character(0), allow_no_input_binding_ = TRUE, 
      priority_ = "event")
})


test_that("{shinytest2} recording: test_conv_der3", {
  local_app_support(test_path("../../inst/shiny/app2"))
  app <- AppDriver$new(test_path("../../inst/shiny/app2"), variant = platform_variant(), 
      name = "test_conv_der3", height = 752, width = 1139)
  app$click("test_data")
  app$set_inputs(conv = "1")
  app$expect_screenshot()
  app$click("run")
  app$set_inputs(conv = "0")
  app$set_inputs(der3 = "1")
  app$click("run")
  app$click("clear_all_curves")
  app$click("run")
  app$expect_screenshot()
})


test_that("{shinytest2} recording: testèchange_xrange", {
  local_app_support(test_path("../../inst/shiny/app2"))
  app <- AppDriver$new(test_path("../../inst/shiny/app2"), variant = platform_variant(), 
      name = "testèchange_xrange", height = 752, width = 1139)
  app$set_inputs(data_xmax = 0.65)
  app$set_inputs(data_xmax = 0.6)
  app$set_inputs(data_xmax = 0.55)
  app$set_inputs(data_xmax = 0.5)
  app$set_inputs(data_xmax = 0.45)
  app$set_inputs(data_xmax = 0.5)
  app$click("test_data")
  app$expect_screenshot()
  app$set_inputs(monot = "1")
  app$click("run")
  app$set_inputs(monot = "0")
  app$set_inputs(conv = "-1")
  app$set_inputs(curve_color = "#00FF55")
  app$click("apply_color")
  app$expect_screenshot()
  app$click("run")
  app$set_inputs(monot = "-1")
  app$set_inputs(curve_color = "#1B1F1C")
  app$click("apply_color")
  app$click("run")
  app$set_inputs(monot = "0")
  app$set_inputs(conv = "0")
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":0,\"pointNumber\":59,\"x\":0.14824120603015076,\"y\":0.2089838696439077}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = character(0), allow_no_input_binding_ = TRUE, 
      priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":0,\"pointNumber\":38,\"x\":0.09547738693467336,\"y\":0.253121016010525}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = character(0), allow_no_input_binding_ = TRUE, 
      priority_ = "event")
  app$click("run")
  app$expect_screenshot()
})


test_that("{shinytest2} recording: test_change_degree", {
  local_app_support(test_path("../../inst/shiny/app2"))
  app <- AppDriver$new(test_path("../../inst/shiny/app2"), variant = platform_variant(), 
      name = "test_change_degree", height = 752, width = 1139)
  app$click("test_data")
  app$set_inputs(degree = 2)
  app$set_inputs(degree = 1)
  app$set_inputs(degree = 0)
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":0,\"pointNumber\":198,\"x\":0.9949748743718593,\"y\":2.0317604798252344}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = character(0), allow_no_input_binding_ = TRUE, 
      priority_ = "event")
  app$expect_screenshot()
  app$click("run")
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":0,\"pointNumber\":185,\"x\":0.9296482412060302,\"y\":1.340035690899476}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = character(0), allow_no_input_binding_ = TRUE, 
      priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":0,\"pointNumber\":161,\"x\":0.8090452261306533,\"y\":1.568304007073723}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = character(0), allow_no_input_binding_ = TRUE, 
      priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":0,\"pointNumber\":157,\"x\":0.7889447236180904,\"y\":1.5602504193107243}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = character(0), allow_no_input_binding_ = TRUE, 
      priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":0,\"pointNumber\":147,\"x\":0.7386934673366834,\"y\":1.5012992709129789}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = character(0), allow_no_input_binding_ = TRUE, 
      priority_ = "event")
  app$set_inputs(auto_knot_count = 18)
  app$set_inputs(auto_knot_count = 19)
  app$set_inputs(auto_knot_count = 20)
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":0,\"pointNumber\":192,\"x\":0.964824120603015,\"y\":1.5153407956754033}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = character(0), allow_no_input_binding_ = TRUE, 
      priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":0,\"pointNumber\":192,\"x\":0.964824120603015,\"y\":1.5153407956754033}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = character(0), allow_no_input_binding_ = TRUE, 
      priority_ = "event")
  app$click("set_auto_knots")
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":4,\"pointNumber\":0,\"x\":0.15789473684210525,\"y\":1.9266990699324613}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = character(0), allow_no_input_binding_ = TRUE, 
      priority_ = "event")
  app$click("run")
  app$click("clear_all_curves")
  app$click("clear_all_curves")
  app$click("run")
  app$expect_screenshot()
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":1,\"pointNumber\":0,\"x\":0,\"y\":1.9266990699324613}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = character(0), allow_no_input_binding_ = TRUE, 
      priority_ = "event")
  app$set_inputs(monot = "1")
  app$click("run")
  app$expect_screenshot()
  app$click("clear_all_curves")
  app$click("run")
  app$expect_screenshot()
  app$set_inputs(degree = 1)
  app$click("run")
  app$click("clear_all_curves")
  app$click("run")
  app$expect_screenshot()
  app$set_inputs(auto_knot_count = 13)
  app$set_inputs(auto_knot_count = 12)
  app$set_inputs(auto_knot_count = 11)
  app$set_inputs(auto_knot_count = 10)
  app$set_inputs(auto_knot_count = 9)
  app$set_inputs(auto_knot_count = 8)
  app$set_inputs(auto_knot_count = 9)
  app$set_inputs(auto_knot_count = 10)
  app$expect_screenshot()
  app$click("run")
  app$set_inputs(monot = "0")
  app$click("run")
  app$click("clear_all_curves")
  app$click("run")
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":0,\"pointNumber\":185,\"x\":0.9296482412060302,\"y\":1.340035690899476}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = character(0), allow_no_input_binding_ = TRUE, 
      priority_ = "event")
  app$click("set_auto_knots")
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":0,\"pointNumber\":156,\"x\":0.7839195979899498,\"y\":1.0925830924700437}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = character(0), allow_no_input_binding_ = TRUE, 
      priority_ = "event")
  app$click("run")
  app$expect_screenshot()
  app$click("clear_all_curves")
  app$click("run")
  app$expect_screenshot()
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":0,\"pointNumber\":177,\"x\":0.8894472361809045,\"y\":2.016254458159658}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = character(0), allow_no_input_binding_ = TRUE, 
      priority_ = "event")
  app$set_inputs(degree = 2)
  app$click("run")
  app$set_inputs(curve_color = "#44FF00")
  app$set_inputs(curve_color = "#58A83B")
  app$click("apply_color")
  app$click("run")
  app$click("clear_all_curves")
  app$click("run")
  app$set_inputs(monot = "1")
  app$expect_screenshot()
  app$click("run")
  app$expect_screenshot()
  app$click("clear_all_curves")
  app$set_inputs(curve_color = "#0B0D0A")
  app$click("apply_color")
  app$click("run")
  app$expect_screenshot()
  app$set_inputs(auto_knot_count = 11)
  app$set_inputs(auto_knot_count = 12)
  app$set_inputs(auto_knot_count = 13)
  app$set_inputs(auto_knot_count = 14)
  app$set_inputs(auto_knot_count = 15)
  app$set_inputs(auto_knot_count = 16)
  app$click("set_auto_knots")
  app$click("run")
  app$expect_screenshot()
  app$click("clear_curves")
  app$click("clear_curves")
  app$click("run")
  app$expect_screenshot()
  app$set_inputs(monot = "0")
  app$set_inputs(curve_color = "#0F0E0C")
  app$set_inputs(curve_color = "#B08433")
  app$click("apply_color")
  app$click("run")
  app$expect_screenshot()
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":19,\"pointNumber\":85,\"x\":0.2842809364548495,\"y\":0.7427842685264491}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = character(0), allow_no_input_binding_ = TRUE, 
      priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":0,\"pointNumber\":59,\"x\":0.2964824120603015,\"y\":0.7272177571305399}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = character(0), allow_no_input_binding_ = TRUE, 
      priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":0,\"pointNumber\":68,\"x\":0.3417085427135678,\"y\":0.760086400624941}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = character(0), allow_no_input_binding_ = TRUE, 
      priority_ = "event")
  app$set_inputs(degree = 3)
  app$set_inputs(degree = 4)
  app$set_inputs(auto_knot_count = 15)
  app$set_inputs(auto_knot_count = 14)
  app$set_inputs(auto_knot_count = 13)
  app$set_inputs(auto_knot_count = 12)
  app$set_inputs(auto_knot_count = 11)
  app$set_inputs(auto_knot_count = 10)
  app$set_inputs(auto_knot_count = 9)
  app$set_inputs(auto_knot_count = 8)
  app$click("clear_all_curves")
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":0,\"pointNumber\":103,\"x\":0.5175879396984925,\"y\":0.945738716734948}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = character(0), allow_no_input_binding_ = TRUE, 
      priority_ = "event")
  app$click("set_auto_knots")
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":0,\"pointNumber\":94,\"x\":0.4723618090452261,\"y\":1.054388556681115}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = character(0), allow_no_input_binding_ = TRUE, 
      priority_ = "event")
  app$expect_screenshot()
  app$click("run")
  app$set_inputs(auto_knot_count = 7)
  app$set_inputs(auto_knot_count = 6)
  app$set_inputs(auto_knot_count = 5)
  app$click("set_auto_knots")
  app$click("run")
  app$set_inputs(auto_knot_count = 6)
  app$set_inputs(auto_knot_count = 7)
  app$set_inputs(auto_knot_count = 8)
  app$set_inputs(auto_knot_count = 9)
  app$set_inputs(auto_knot_count = 10)
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":0,\"pointNumber\":17,\"x\":0.08542713567839195,\"y\":0.5665034405590677}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = character(0), allow_no_input_binding_ = TRUE, 
      priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":0,\"pointNumber\":64,\"x\":0.32160804020100503,\"y\":0.6319158079620106}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = character(0), allow_no_input_binding_ = TRUE, 
      priority_ = "event")
  app$click("run")
  app$click("clear_all_curves")
  app$click("run")
  app$click("set_auto_knots")
  app$click("clear_all_curves")
  app$click("run")
  app$set_inputs(degree = 3)
  app$click("run")
  app$click("clear_all_curves")
  app$set_inputs(auto_knot_count = 11)
  app$set_inputs(auto_knot_count = 10)
  app$set_inputs(auto_knot_count = 9)
  app$click("set_auto_knots")
  app$set_inputs(degree = 4)
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":0,\"pointNumber\":109,\"x\":0.5477386934673367,\"y\":0.7809144531458475}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = character(0), allow_no_input_binding_ = TRUE, 
      priority_ = "event")
  app$click("run")
  app$set_inputs(auto_knot_count = 10)
  app$set_inputs(auto_knot_count = 11)
  app$click("run")
  app$click("set_auto_knots")
  app$click("run")
  app$expect_screenshot()
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":14,\"pointNumber\":299,\"x\":1,\"y\":2.1739924360697906}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = character(0), allow_no_input_binding_ = TRUE, 
      priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":0,\"pointNumber\":172,\"x\":0.864321608040201,\"y\":1.5823469539302035}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = character(0), allow_no_input_binding_ = TRUE, 
      priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":0,\"pointNumber\":184,\"x\":0.9246231155778895,\"y\":1.4082162215752208}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = character(0), allow_no_input_binding_ = TRUE, 
      priority_ = "event")
  app$click("clear_all_curves")
  app$click("run")
  app$expect_screenshot()
  app$set_inputs(monot = "1")
  app$click("run")
  app$expect_screenshot()
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":6,\"pointNumber\":0,\"x\":0.5,\"y\":1.9266990699324613}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = character(0), allow_no_input_binding_ = TRUE, 
      priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":0,\"pointNumber\":158,\"x\":0.7939698492462312,\"y\":1.4207071820269401}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = character(0), allow_no_input_binding_ = TRUE, 
      priority_ = "event")
  app$click("clear_all_curves")
  app$click("run")
  app$expect_screenshot()
  app$set_inputs(degree = 5)
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":0,\"pointNumber\":156,\"x\":0.7839195979899498,\"y\":1.0925830924700437}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = character(0), allow_no_input_binding_ = TRUE, 
      priority_ = "event")
  app$click("run")
  app$set_inputs(curve_color = "#171615")
  app$click("apply_color")
  app$click("run")
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":0,\"pointNumber\":148,\"x\":0.7437185929648241,\"y\":0.9962872576835496}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = character(0), allow_no_input_binding_ = TRUE, 
      priority_ = "event")
  app$set_inputs(degree = 6)
  app$set_inputs(degree = 7)
  app$set_inputs(degree = 8)
  app$set_inputs(degree = 10)
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":0,\"pointNumber\":185,\"x\":0.9296482412060302,\"y\":1.340035690899476}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = character(0), allow_no_input_binding_ = TRUE, 
      priority_ = "event")
  app$click("clear_all")
  app$click("test_data")
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":0,\"pointNumber\":174,\"x\":0.8743718592964824,\"y\":2.2124452080540964}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = character(0), allow_no_input_binding_ = TRUE, 
      priority_ = "event")
  app$click("run")
  app$expect_screenshot()
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":11,\"pointNumber\":0,\"x\":1,\"y\":1.9266990699324613}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = character(0), allow_no_input_binding_ = TRUE, 
      priority_ = "event")
})


test_that("{shinytest2} recording: test_change_knots", {
  local_app_support(test_path("../../inst/shiny/app2"))
  app <- AppDriver$new(test_path("../../inst/shiny/app2"), variant = platform_variant(), 
      name = "test_change_knots", height = 752, width = 1139)
  app$click("test_data")
  app$click("test_data")
  app$set_inputs(auto_knot_count = 2)
  app$click("set_auto_knots")
  app$set_inputs(degree = 0)
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":0,\"pointNumber\":164,\"x\":0.8241206030150754,\"y\":1.7984507129354401}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = character(0), allow_no_input_binding_ = TRUE, 
      priority_ = "event")
  app$expect_screenshot()
  app$click("run")
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":0,\"pointNumber\":186,\"x\":0.9346733668341709,\"y\":1.4134868049459397}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = character(0), allow_no_input_binding_ = TRUE, 
      priority_ = "event")
  app$set_inputs(degree = 1)
  app$click("run")
  app$expect_screenshot()
  app$set_inputs(auto_knot_count = 3)
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":4,\"pointNumber\":23,\"x\":0.07692307692307693,\"y\":0.971735798434495}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = character(0), allow_no_input_binding_ = TRUE, 
      priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":4,\"pointNumber\":254,\"x\":0.8494983277591973,\"y\":0.971735798434495}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = character(0), allow_no_input_binding_ = TRUE, 
      priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":0,\"pointNumber\":156,\"x\":0.7839195979899498,\"y\":1.0925830924700437}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = character(0), allow_no_input_binding_ = TRUE, 
      priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":0,\"pointNumber\":167,\"x\":0.8391959798994975,\"y\":1.9336516058625222}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = character(0), allow_no_input_binding_ = TRUE, 
      priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":0,\"pointNumber\":185,\"x\":0.9296482412060302,\"y\":1.340035690899476}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = character(0), allow_no_input_binding_ = TRUE, 
      priority_ = "event")
  app$click("set_auto_knots")
  app$set_inputs(curve_color = "#00FF40")
  app$set_inputs(curve_color = "#33AB51")
  app$click("apply_color")
  app$click("run")
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":0,\"pointNumber\":185,\"x\":0.9296482412060302,\"y\":1.340035690899476}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = character(0), allow_no_input_binding_ = TRUE, 
      priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":1,\"pointNumber\":0,\"x\":0,\"y\":1.9266990699324613}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = character(0), allow_no_input_binding_ = TRUE, 
      priority_ = "event")
  app$set_inputs(degree = 2)
  app$set_inputs(degree = 3)
  app$set_inputs(degree = 4)
  app$set_inputs(degree = 6)
  app$set_inputs(degree = 7)
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":5,\"pointNumber\":0,\"x\":0,\"y\":0.971735798434495}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = character(0), allow_no_input_binding_ = TRUE, 
      priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":0,\"pointNumber\":137,\"x\":0.6884422110552764,\"y\":1.7192698305263345}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = character(0), allow_no_input_binding_ = TRUE, 
      priority_ = "event")
  app$click("run")
  app$expect_screenshot()
  app$click("clear_all")
  app$click("test_data")
  app$set_inputs(degree = 6)
  app$set_inputs(degree = 4)
  app$set_inputs(degree = 3)
  app$click("add_knot_mode")
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":0,\"pointNumber\":46,\"x\":0.23115577889447236,\"y\":0.9226041663012976}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = character(0), allow_no_input_binding_ = TRUE, 
      priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":0,\"pointNumber\":50,\"x\":0.25125628140703515,\"y\":0.8076873283890347}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = character(0), allow_no_input_binding_ = TRUE, 
      priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":0,\"pointNumber\":52,\"x\":0.2613065326633166,\"y\":0.864064469271778}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_click-plot` = "[{\"curveNumber\":0,\"pointNumber\":52,\"x\":0.2613065326633166,\"y\":0.864064469271778}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":0,\"pointNumber\":50,\"x\":0.25125628140703515,\"y\":0.8076873283890347}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = character(0), allow_no_input_binding_ = TRUE, 
      priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":0,\"pointNumber\":48,\"x\":0.24120603015075376,\"y\":0.7418667925393986}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = character(0), allow_no_input_binding_ = TRUE, 
      priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":0,\"pointNumber\":47,\"x\":0.23618090452261306,\"y\":0.6354161958869212}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = character(0), allow_no_input_binding_ = TRUE, 
      priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":0,\"pointNumber\":33,\"x\":0.1658291457286432,\"y\":0.45930681460965805}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = character(0), allow_no_input_binding_ = TRUE, 
      priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":0,\"pointNumber\":34,\"x\":0.1708542713567839,\"y\":0.3145940834472206}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = character(0), allow_no_input_binding_ = TRUE, 
      priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":0,\"pointNumber\":32,\"x\":0.16080402010050251,\"y\":0.25558861383489}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = character(0), allow_no_input_binding_ = TRUE, 
      priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":0,\"pointNumber\":20,\"x\":0.10050251256281408,\"y\":0.18298606445827825}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = character(0), allow_no_input_binding_ = TRUE, 
      priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":0,\"pointNumber\":27,\"x\":0.135678391959799,\"y\":0.11516719160690564}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = character(0), allow_no_input_binding_ = TRUE, 
      priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":0,\"pointNumber\":30,\"x\":0.15075376884422112,\"y\":0.0948160261673831}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_click-plot` = "[{\"curveNumber\":0,\"pointNumber\":30,\"x\":0.15075376884422112,\"y\":0.0948160261673831}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":0,\"pointNumber\":30,\"x\":0.15075376884422112,\"y\":0.0948160261673831}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = character(0), allow_no_input_binding_ = TRUE, 
      priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":0,\"pointNumber\":51,\"x\":0.2562814070351759,\"y\":0.4939560632611173}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = character(0), allow_no_input_binding_ = TRUE, 
      priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":0,\"pointNumber\":62,\"x\":0.31155778894472363,\"y\":0.46401425916424244}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = character(0), allow_no_input_binding_ = TRUE, 
      priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":0,\"pointNumber\":73,\"x\":0.36683417085427134,\"y\":0.49544480804674373}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = character(0), allow_no_input_binding_ = TRUE, 
      priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":0,\"pointNumber\":76,\"x\":0.38190954773869346,\"y\":0.4640125506205808}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = character(0), allow_no_input_binding_ = TRUE, 
      priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":0,\"pointNumber\":75,\"x\":0.3768844221105528,\"y\":0.35002988958231607}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = character(0), allow_no_input_binding_ = TRUE, 
      priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":0,\"pointNumber\":71,\"x\":0.35678391959798994,\"y\":0.34087082021828663}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = character(0), allow_no_input_binding_ = TRUE, 
      priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":0,\"pointNumber\":67,\"x\":0.33668341708542715,\"y\":0.3060967358330967}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_click-plot` = "[{\"curveNumber\":0,\"pointNumber\":67,\"x\":0.33668341708542715,\"y\":0.3060967358330967}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":0,\"pointNumber\":71,\"x\":0.35678391959798994,\"y\":0.34087082021828663}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = character(0), allow_no_input_binding_ = TRUE, 
      priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":0,\"pointNumber\":158,\"x\":0.7939698492462312,\"y\":1.4207071820269401}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = character(0), allow_no_input_binding_ = TRUE, 
      priority_ = "event")
  app$expect_screenshot()
  app$click("run")
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":0,\"pointNumber\":138,\"x\":0.6934673366834171,\"y\":1.2760876523442177}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = character(0), allow_no_input_binding_ = TRUE, 
      priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":0,\"pointNumber\":129,\"x\":0.6482412060301508,\"y\":1.3100896483491546}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = character(0), allow_no_input_binding_ = TRUE, 
      priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":0,\"pointNumber\":126,\"x\":0.6331658291457286,\"y\":1.3813399714462922}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = character(0), allow_no_input_binding_ = TRUE, 
      priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":0,\"pointNumber\":85,\"x\":0.4271356783919598,\"y\":1.2162288121146267}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = character(0), allow_no_input_binding_ = TRUE, 
      priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":0,\"pointNumber\":81,\"x\":0.40703517587939697,\"y\":0.9424390221329783}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = character(0), allow_no_input_binding_ = TRUE, 
      priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":0,\"pointNumber\":80,\"x\":0.4020100502512563,\"y\":0.7023925771802697}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = character(0), allow_no_input_binding_ = TRUE, 
      priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":0,\"pointNumber\":82,\"x\":0.4120603015075377,\"y\":0.563420498053206}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_click-plot` = "[{\"curveNumber\":0,\"pointNumber\":82,\"x\":0.4120603015075377,\"y\":0.563420498053206}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":0,\"pointNumber\":86,\"x\":0.4321608040201005,\"y\":0.6351423242337597}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = character(0), allow_no_input_binding_ = TRUE, 
      priority_ = "event")
  app$set_inputs(curve_color = "#1B241D")
  app$click("run")
  app$expect_screenshot()
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":0,\"pointNumber\":174,\"x\":0.8743718592964824,\"y\":2.2124452080540964}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = character(0), allow_no_input_binding_ = TRUE, 
      priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":2,\"pointNumber\":0,\"x\":0.15075376884422112,\"y\":1.9266990699324613}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = character(0), allow_no_input_binding_ = TRUE, 
      priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":3,\"pointNumber\":0,\"x\":0.2613065326633166,\"y\":1.9266990699324613}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = character(0), allow_no_input_binding_ = TRUE, 
      priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":5,\"pointNumber\":0,\"x\":0.4120603015075377,\"y\":1.9266990699324613}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = character(0), allow_no_input_binding_ = TRUE, 
      priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":6,\"pointNumber\":0,\"x\":0.5,\"y\":1.9266990699324613}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = character(0), allow_no_input_binding_ = TRUE, 
      priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":8,\"pointNumber\":5,\"x\":0.5,\"y\":1.9266990699324613}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = character(0), allow_no_input_binding_ = TRUE, 
      priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":6,\"pointNumber\":0,\"x\":0.5,\"y\":1.9266990699324613}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = character(0), allow_no_input_binding_ = TRUE, 
      priority_ = "event")
  app$click("add_knot_mode")
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":0,\"pointNumber\":198,\"x\":0.9949748743718593,\"y\":2.0317604798252344}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = character(0), allow_no_input_binding_ = TRUE, 
      priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":0,\"pointNumber\":197,\"x\":0.9899497487437187,\"y\":1.9461832508496908}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = character(0), allow_no_input_binding_ = TRUE, 
      priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":8,\"pointNumber\":6,\"x\":1,\"y\":1.9266990699324613}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = character(0), allow_no_input_binding_ = TRUE, 
      priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":10,\"pointNumber\":299,\"x\":1,\"y\":1.8930558305699607}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = character(0), allow_no_input_binding_ = TRUE, 
      priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":7,\"pointNumber\":0,\"x\":1,\"y\":1.9266990699324613}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = character(0), allow_no_input_binding_ = TRUE, 
      priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":8,\"pointNumber\":6,\"x\":1,\"y\":1.9266990699324613}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = character(0), allow_no_input_binding_ = TRUE, 
      priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":7,\"pointNumber\":0,\"x\":1,\"y\":1.9266990699324613}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_click-plot` = "[{\"curveNumber\":7,\"pointNumber\":0,\"x\":1,\"y\":1.9266990699324613}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":9,\"pointNumber\":0,\"x\":1,\"y\":1.9266990699324613}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = character(0), allow_no_input_binding_ = TRUE, 
      priority_ = "event")
  app$click("remove_knot")
  app$expect_screenshot()
  app$click("run")
  app$click("add_knot_mode")
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":0,\"pointNumber\":137,\"x\":0.6884422110552764,\"y\":1.7192698305263345}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = character(0), allow_no_input_binding_ = TRUE, 
      priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":0,\"pointNumber\":134,\"x\":0.6733668341708543,\"y\":1.6135492789127472}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = character(0), allow_no_input_binding_ = TRUE, 
      priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":0,\"pointNumber\":140,\"x\":0.7035175879396985,\"y\":1.5184112504500784}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = character(0), allow_no_input_binding_ = TRUE, 
      priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":0,\"pointNumber\":132,\"x\":0.6633165829145728,\"y\":1.5586726749927786}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = character(0), allow_no_input_binding_ = TRUE, 
      priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":0,\"pointNumber\":131,\"x\":0.6582914572864321,\"y\":1.4997545266601933}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = character(0), allow_no_input_binding_ = TRUE, 
      priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":0,\"pointNumber\":145,\"x\":0.7286432160804021,\"y\":1.089997959006622}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = character(0), allow_no_input_binding_ = TRUE, 
      priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":0,\"pointNumber\":148,\"x\":0.7437185929648241,\"y\":0.9962872576835496}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = character(0), allow_no_input_binding_ = TRUE, 
      priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":0,\"pointNumber\":132,\"x\":0.6633165829145728,\"y\":1.5586726749927786}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = character(0), allow_no_input_binding_ = TRUE, 
      priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":0,\"pointNumber\":134,\"x\":0.6733668341708543,\"y\":1.6135492789127472}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = character(0), allow_no_input_binding_ = TRUE, 
      priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":0,\"pointNumber\":137,\"x\":0.6884422110552764,\"y\":1.7192698305263345}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = character(0), allow_no_input_binding_ = TRUE, 
      priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":0,\"pointNumber\":133,\"x\":0.6683417085427136,\"y\":1.8106614381022146}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = character(0), allow_no_input_binding_ = TRUE, 
      priority_ = "event")
  app$set_inputs(`plotly_click-plot` = "[{\"curveNumber\":0,\"pointNumber\":133,\"x\":0.6683417085427136,\"y\":1.8106614381022146}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":7,\"pointNumber\":0,\"x\":0.6683417085427136,\"y\":1.9266990699324613}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = character(0), allow_no_input_binding_ = TRUE, 
      priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":0,\"pointNumber\":164,\"x\":0.8241206030150754,\"y\":1.7984507129354401}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = character(0), allow_no_input_binding_ = TRUE, 
      priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":0,\"pointNumber\":176,\"x\":0.8844221105527639,\"y\":1.9639928678768555}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = character(0), allow_no_input_binding_ = TRUE, 
      priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":0,\"pointNumber\":182,\"x\":0.914572864321608,\"y\":1.9364448758885793}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = character(0), allow_no_input_binding_ = TRUE, 
      priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":0,\"pointNumber\":189,\"x\":0.949748743718593,\"y\":1.9442171727874884}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = character(0), allow_no_input_binding_ = TRUE, 
      priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":0,\"pointNumber\":183,\"x\":0.9195979899497487,\"y\":2.053170378076227}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = character(0), allow_no_input_binding_ = TRUE, 
      priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":0,\"pointNumber\":179,\"x\":0.8994974874371859,\"y\":1.991832198789199}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = character(0), allow_no_input_binding_ = TRUE, 
      priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":0,\"pointNumber\":178,\"x\":0.8944723618090452,\"y\":1.9726117186403842}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = character(0), allow_no_input_binding_ = TRUE, 
      priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":0,\"pointNumber\":182,\"x\":0.914572864321608,\"y\":1.9364448758885793}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_click-plot` = "[{\"curveNumber\":0,\"pointNumber\":182,\"x\":0.914572864321608,\"y\":1.9364448758885793}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":8,\"pointNumber\":0,\"x\":0.914572864321608,\"y\":1.9266990699324613}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = character(0), allow_no_input_binding_ = TRUE, 
      priority_ = "event")
  app$expect_screenshot()
  app$click("clear_all_curves")
  app$click("run")
  app$expect_screenshot()
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":3,\"pointNumber\":0,\"x\":0.2613065326633166,\"y\":1.9266990699324613}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = character(0), allow_no_input_binding_ = TRUE, 
      priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":0,\"pointNumber\":96,\"x\":0.4824120603015075,\"y\":1.2386406255336635}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = character(0), allow_no_input_binding_ = TRUE, 
      priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":0,\"pointNumber\":122,\"x\":0.6130653266331658,\"y\":1.2045067604627935}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = character(0), allow_no_input_binding_ = TRUE, 
      priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":10,\"pointNumber\":200,\"x\":0.6688963210702341,\"y\":1.264795947773738}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = character(0), allow_no_input_binding_ = TRUE, 
      priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":10,\"pointNumber\":203,\"x\":0.6789297658862876,\"y\":1.2897779769571223}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = character(0), allow_no_input_binding_ = TRUE, 
      priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":0,\"pointNumber\":136,\"x\":0.6834170854271356,\"y\":1.3393916616629404}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = character(0), allow_no_input_binding_ = TRUE, 
      priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":0,\"pointNumber\":143,\"x\":0.7185929648241206,\"y\":1.3909501556538908}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = character(0), allow_no_input_binding_ = TRUE, 
      priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":10,\"pointNumber\":218,\"x\":0.7290969899665551,\"y\":1.4115379944601685}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = character(0), allow_no_input_binding_ = TRUE, 
      priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":0,\"pointNumber\":153,\"x\":0.7688442211055276,\"y\":1.454274042643156}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = character(0), allow_no_input_binding_ = TRUE, 
      priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":0,\"pointNumber\":152,\"x\":0.7638190954773869,\"y\":1.3273889883871275}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = character(0), allow_no_input_binding_ = TRUE, 
      priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":0,\"pointNumber\":156,\"x\":0.7839195979899498,\"y\":1.0925830924700437}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = character(0), allow_no_input_binding_ = TRUE, 
      priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":0,\"pointNumber\":145,\"x\":0.7286432160804021,\"y\":1.089997959006622}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_click-plot` = "[{\"curveNumber\":0,\"pointNumber\":145,\"x\":0.7286432160804021,\"y\":1.089997959006622}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_click-plot` = "[{\"curveNumber\":0,\"pointNumber\":145,\"x\":0.7286432160804021,\"y\":1.089997959006622}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = character(0), allow_no_input_binding_ = TRUE, 
      priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":0,\"pointNumber\":135,\"x\":0.678391959798995,\"y\":1.1586531243951492}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = character(0), allow_no_input_binding_ = TRUE, 
      priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":11,\"pointNumber\":175,\"x\":0.5852842809364548,\"y\":1.0724245304220794}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = character(0), allow_no_input_binding_ = TRUE, 
      priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":0,\"pointNumber\":112,\"x\":0.5628140703517588,\"y\":1.000103271287157}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = character(0), allow_no_input_binding_ = TRUE, 
      priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":0,\"pointNumber\":113,\"x\":0.5678391959798995,\"y\":0.8634770546692735}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = character(0), allow_no_input_binding_ = TRUE, 
      priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":0,\"pointNumber\":116,\"x\":0.5829145728643216,\"y\":0.7842335748474379}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_click-plot` = "[{\"curveNumber\":0,\"pointNumber\":116,\"x\":0.5829145728643216,\"y\":0.7842335748474379}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":0,\"pointNumber\":118,\"x\":0.592964824120603,\"y\":0.876626062115831}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = character(0), allow_no_input_binding_ = TRUE, 
      priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":0,\"pointNumber\":145,\"x\":0.7286432160804021,\"y\":1.089997959006622}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = character(0), allow_no_input_binding_ = TRUE, 
      priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":0,\"pointNumber\":158,\"x\":0.7939698492462312,\"y\":1.4207071820269401}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = character(0), allow_no_input_binding_ = TRUE, 
      priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":0,\"pointNumber\":172,\"x\":0.864321608040201,\"y\":1.5823469539302035}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = character(0), allow_no_input_binding_ = TRUE, 
      priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":0,\"pointNumber\":175,\"x\":0.8793969849246231,\"y\":1.7442071784711493}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = character(0), allow_no_input_binding_ = TRUE, 
      priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":12,\"pointNumber\":266,\"x\":0.8896321070234113,\"y\":1.75016680573642}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = character(0), allow_no_input_binding_ = TRUE, 
      priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":12,\"pointNumber\":268,\"x\":0.8963210702341137,\"y\":1.762077700583175}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = character(0), allow_no_input_binding_ = TRUE, 
      priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":10,\"pointNumber\":0,\"x\":0.914572864321608,\"y\":1.9266990699324613}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = character(0), allow_no_input_binding_ = TRUE, 
      priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":0,\"pointNumber\":176,\"x\":0.8844221105527639,\"y\":1.9639928678768555}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = character(0), allow_no_input_binding_ = TRUE, 
      priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":0,\"pointNumber\":173,\"x\":0.8693467336683417,\"y\":2.1017619368930154}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = character(0), allow_no_input_binding_ = TRUE, 
      priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":0,\"pointNumber\":192,\"x\":0.964824120603015,\"y\":1.5153407956754033}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = character(0), allow_no_input_binding_ = TRUE, 
      priority_ = "event")
  app$click("run")
  app$expect_screenshot()
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":2,\"pointNumber\":0,\"x\":0.15075376884422112,\"y\":1.9266990699324613}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = character(0), allow_no_input_binding_ = TRUE, 
      priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":3,\"pointNumber\":0,\"x\":0.2613065326633166,\"y\":1.9266990699324613}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_click-plot` = "[{\"curveNumber\":3,\"pointNumber\":0,\"x\":0.2613065326633166,\"y\":1.9266990699324613}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":12,\"pointNumber\":0,\"x\":0.2613065326633166,\"y\":1.9266990699324613}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = character(0), allow_no_input_binding_ = TRUE, 
      priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":4,\"pointNumber\":0,\"x\":0.33668341708542715,\"y\":1.9266990699324613}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = character(0), allow_no_input_binding_ = TRUE, 
      priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":11,\"pointNumber\":3,\"x\":0.33668341708542715,\"y\":1.9266990699324613}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = character(0), allow_no_input_binding_ = TRUE, 
      priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":4,\"pointNumber\":0,\"x\":0.33668341708542715,\"y\":1.9266990699324613}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = character(0), allow_no_input_binding_ = TRUE, 
      priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":11,\"pointNumber\":3,\"x\":0.33668341708542715,\"y\":1.9266990699324613}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_click-plot` = "[{\"curveNumber\":11,\"pointNumber\":3,\"x\":0.33668341708542715,\"y\":1.9266990699324613}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":5,\"pointNumber\":0,\"x\":0.4120603015075377,\"y\":1.9266990699324613}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = character(0), allow_no_input_binding_ = TRUE, 
      priority_ = "event")
  app$set_inputs(`plotly_click-plot` = "[{\"curveNumber\":5,\"pointNumber\":0,\"x\":0.4120603015075377,\"y\":1.9266990699324613}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":12,\"pointNumber\":0,\"x\":0.4120603015075377,\"y\":1.9266990699324613}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = character(0), allow_no_input_binding_ = TRUE, 
      priority_ = "event")
  app$click("remove_knot")
  app$click("remove_knot")
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":3,\"pointNumber\":0,\"x\":0.2613065326633166,\"y\":1.9266990699324613}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = character(0), allow_no_input_binding_ = TRUE, 
      priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":0,\"pointNumber\":85,\"x\":0.4271356783919598,\"y\":1.2162288121146267}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = character(0), allow_no_input_binding_ = TRUE, 
      priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":0,\"pointNumber\":95,\"x\":0.47738693467336685,\"y\":1.1129919083924784}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = character(0), allow_no_input_binding_ = TRUE, 
      priority_ = "event")
  app$set_inputs(curve_color = "#261C21")
  app$set_inputs(curve_color = "#D44487")
  app$click("apply_color")
  app$click("run")
  app$expect_screenshot()
  app$click("clear_all_curves")
  app$click("run")
  app$set_inputs(auto_knot_count = 2)
  app$click("set_auto_knots")
  app$set_inputs(auto_knot_count = 3)
  app$click("set_auto_knots")
  app$set_inputs(auto_knot_count = 2)
  app$click("set_auto_knots")
  app$click("remove_knot")
  app$click("remove_knot")
  app$click("remove_knot")
  app$click("set_auto_knots")
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":1,\"pointNumber\":0,\"x\":0,\"y\":1.9266990699324613}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = character(0), allow_no_input_binding_ = TRUE, 
      priority_ = "event")
  app$click("remove_knot")
  app$click("remove_knot")
  app$click("remove_knot")
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":1,\"pointNumber\":0,\"x\":0,\"y\":1.9266990699324613}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = character(0), allow_no_input_binding_ = TRUE, 
      priority_ = "event")
  app$click("remove_knot")
  app$click("remove_knot")
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":2,\"pointNumber\":0,\"x\":0.15075376884422112,\"y\":1.9266990699324613}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = character(0), allow_no_input_binding_ = TRUE, 
      priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":6,\"pointNumber\":1,\"x\":0.15075376884422112,\"y\":1.9266990699324613}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_click-plot` = "[{\"curveNumber\":6,\"pointNumber\":1,\"x\":0.15075376884422112,\"y\":1.9266990699324613}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = "[{\"curveNumber\":7,\"pointNumber\":0,\"x\":0.15075376884422112,\"y\":1.9266990699324613}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-plot` = character(0), allow_no_input_binding_ = TRUE, 
      priority_ = "event")
  app$click("remove_knot")
  app$click("remove_knot")
  app$click("remove_knot")
  app$click("set_auto_knots")
})
