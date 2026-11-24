
  app <- AppDriver$new(test_path("../../inst/shiny/app2"), variant = platform_variant(),
                       name = "test_demo_comp_shocks", height = 940, width = 1498)

  app$set_inputs(main_tabs = "Demo")
  app$wait_for_idle()

  app$set_inputs(degree = 1)
  app$get_screenshot("man/figures/demo1.png", selector = "viewport")

  app$click("demo_comp", wait_ = FALSE)
  app$wait_for_idle(timeout = 30000)  # Attendre plus longtemps

  app$wait_for_idle()
  app$get_screenshot("man/figures/demo2.png", selector = "viewport")

  app$set_inputs(degree = 2)
  app$wait_for_idle()
  app$get_screenshot("man/figures/demo3.png", selector = "viewport")
  app$wait_for_idle()
  app$get_screenshot("man/figures/demo4.png", selector = "viewport")
  app$wait_for_idle()
  app$click("demo_comp")
  app$wait_for_idle()
  app$get_screenshot("man/figures/demo5.png", selector = "viewport")


  app$click("demo_comp", wait_ = FALSE)
  app$wait_for_idle(timeout = 30000)  # Attendre plus longtemps
  app$wait_for_idle()
  app$get_screenshot("man/figures/demo6.png", selector = "viewport")
  app$set_inputs(degree = 5)
  app$click("demo_shock")
  app$wait_for_idle()
  app$get_screenshot("man/figures/demo7.png", selector = "viewport")

  app$set_inputs(degree = 3)
  app$wait_for_idle()
  app$get_screenshot("man/figures/demo8.png", selector = "viewport")

  app$stop()


