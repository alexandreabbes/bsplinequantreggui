app <- AppDriver$new(test_path("../../inst/shiny/app2"), variant = platform_variant(),
                     name = "test_verbose_Rcode", height = 940, width = 1498)





  app$click("generate_custom")
  app$click("set_auto_knots")
  app$wait_for_idle()#timeout = 30000)  # Attendre plus longtemps
  app$click("verbose")
  app$click("run")
  app$wait_for_idle(timeout = 10000)  # Attendre plus longtemps
  app$get_screenshot("man/figures/verbose0.png", selector = "viewport")

  app$set_inputs(main_tabs = "Console")
  app$wait_for_idle(timeout = 10000)  # Attendre plus longtemps
  app$get_screenshot("man/figures/verbose1.png", selector = "viewport")
  app$wait_for_idle(timeout = 10000)  # Attendre plus longtemps
  app$set_inputs(main_tabs = "R Code", wait=FALSE)
  app$wait_for_idle(timeout = 10000)  # Attendre plus longtemps
  app$get_screenshot("man/figures/verbose2.png", selector = "viewport")

  app$stop()
