library(shinytest2)

test_that("{shinytest2} recording: test_demo", {
  local_app_support(test_path("../../inst/shiny/app2"))
  app <- AppDriver$new(test_path("../../inst/shiny/app2"), variant = platform_variant(), 
      name = "test_demo", height = 927, width = 1486)
  app$click("demo_comp")
  app$expect_screenshot()
})
