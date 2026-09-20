#======================================
#============data generation===========
#======================================

generate_custom<-function(){
  tryCatch({
    n <- input$n_points
    xmin <- input$data_xmin
    xmax <- input$data_xmax
    x <- as.vector(seq(xmin, xmax, length.out = n))
    func_str <- gsub("sin\\(", "sin(", input$custom_func)
    func_str <- gsub("cos\\(", "cos(", func_str)
    func_str <- gsub("pi", "pi", func_str)
    func_str <- gsub("randn\\(", "rnorm(", func_str)
    y <- eval(parse(text = func_str))
    values$xtab <- x
    values$ytab <- y
    values$data_name <- "Custom function"
    values$fitted <- NULL
    values$curve_lines <- list()
    values$regions <- list()
    showNotification("Data generated", type = "message")
  }, error = function(e) {
    showNotification(paste("Error:", e$message), type = "error")
  })
}


test_data<-function()
{
  set.seed(24)
  n <- 200
  xmin <- input$data_xmin
  xmax <- input$data_xmax
  x <- as.vector(seq(xmin, xmax, length.out = n))
  y <- as.vector(2 * x + 0.2 * sin(10 * pi * x) + 0.2 * rnorm(n))
  values$xtab <- x
  values$ytab <- y
  values$data_name <- paste("Test [", xmin, ",", xmax, "]")
  values$fitted <- NULL
  values$curve_lines <- list()
  values$regions <- list()
  showNotification("Test data generated", type = "message")

}

temp_data<-function()
{
  withProgress(message = "Loading...", {
    temp_data <- c(
      -0.32,
      -0.32,
      -0.40,
      -0.39,
      -0.65,
      -0.43,
      -0.40,
      -0.52,
      -0.30,
      -0.12,-0.40,
      -0.42,
      -0.39,
      -0.45,
      -0.35,
      -0.36,
      -0.19,
      -0.14,
      -0.37,
      -0.22,
      0.00,
      -0.08,
      -0.24,
      -0.36,
      -0.49,
      -0.27,
      -0.19,
      -0.43,
      -0.29,
      -0.30,-0.29,
      -0.29,
      -0.28,
      -0.23,
      -0.04,
      -0.02,
      -0.24,
      -0.42,
      -0.35,
      -0.16,-0.17,
      -0.09,
      -0.13,
      -0.16,
      -0.14,
      -0.14,
      0.10,
      -0.03,
      0.03,
      -0.18,-0.06,
      0.04,
      0.02,
      -0.13,
      0.03,
      -0.06,
      0.02,
      0.13,
      0.13,
      -0.03,
      0.15,
      0.12,
      0.10,
      0.04,
      0.11,
      -0.04,
      0.01,
      0.13,
      -0.01,
      -0.06,-0.14,
      -0.02,
      0.04,
      0.14,
      -0.07,
      -0.06,
      -0.17,
      0.10,
      0.10,
      0.05,-0.01,
      0.08,
      0.02,
      0.02,
      -0.26,
      -0.16,
      -0.09,
      -0.02,
      -0.12,
      0.03,
      0.04,
      -0.11,
      -0.07,
      0.19,
      -0.07,
      -0.05,
      -0.22,
      0.16,
      0.09,
      0.14,
      0.28,
      0.39,
      0.07,
      0.29,
      0.11,
      0.11,
      0.16,
      0.32,
      0.35,
      0.25,
      0.47,
      0.41,
      0.13
    )
    years <- 1880:1992
    #x <- (years - 1880) / (1992 - 1880)
    x<-years
    y <- temp_data
    values$xtab <- x
    values$ytab <- y
    values$data_name <- "Temperature (1880-1992)"
    values$fitted <- NULL
    values$curve_lines <- list()
    values$regions <- list()
    year_knots <- c(1880, 1889, 1900, 1910, 1930, 1940, 1965, 1992)
    #knot <- (year_knots - 1880) / (1992 - 1880)
    knot<-year_knots
    values$manual_knot <- knot[2:7]

    values$auto_knot_count <- 2
    updateNumericInput(session,'auto_knot_count',value=2)
    #      values$knot<-sort(union(values$manual_knot,values$auto_knot))
    values$knot_multiplicity<-c(values$degree,rep(1,6),values$degree)

    showNotification("Temperature data loaded", type = "message")
    updateNumericInput(session, "data_xmin", value = min(values$xtab))
    updateNumericInput(session, "data_xmax", value = max(values$xtab))

  })
}


# ============ EXCEL IMPORT ============

load_excel<-function()
{
  if (!requireNamespace("readxl", quietly = TRUE)) {
    showNotification(
      "Install 'readxl' to read Excel files: install.packages('readxl')",
      type = "error",
      duration = 10
    )
    return()
  }

  file_path <- file.choose()
  if (is.na(file_path))
    return()
  tryCatch(
    {
      df <- readxl::read_excel(file_path)
      df <- as.data.frame(df)

      if (ncol(df) < 2) {
        showNotification("File must have at least 2 columns!", type = "error")
        return()
      }

      x_col <- df[, 1]
      y_col <- df[, 2]

      valid <- !is.na(x_col) & !is.na(y_col)
      x_col <- x_col[valid]
      y_col <- y_col[valid]

      if (length(x_col) < 3) {
        showNotification("Not enough data (minimum 3 points)", type = "error")
        return()
      }

      values$xtab <- as.vector(x_col)
      values$ytab <- as.vector(y_col)
      values$data_name <- basename(file_path)
      values$fitted <- NULL
      values$curve_lines <- list()
      values$regions <- list()

      updateNumericInput(session, "data_xmin", value = min(values$xtab))
      updateNumericInput(session, "data_xmax", value = max(values$xtab))

      values$manual_knot <- vector()
      kn <- max(input$auto_knot_count, 2) - 1
      values$knot <- as.numeric(quantile(values$xtab, probs = (0:(kn)) / (kn)))

      showNotification(paste(
        "File loaded:",
        basename(file_path),
        "-",
        length(x_col),
        "points"
      ),
      type = "success") },

    error = function(e) {
      showNotification(paste("Read error:", e$message), type = "error")
    }
  )
}

# ====================================
# ============ CSV IMPORT ============
load_csv<-function()
{
  file_path <- file.choose()
  if (is.na(file_path))
    return()

  tryCatch({
    df <- read.csv(file_path, header = TRUE)

    if (ncol(df) < 2) {
      showNotification("File must have at least 2 columns!", type = "error")
      return()
    }

    x_col <- df[, 1]
    y_col <- df[, 2]

    valid <- !is.na(x_col) & !is.na(y_col)
    x_col <- x_col[valid]
    y_col <- y_col[valid]


    if (length(x_col) < 3) {
      showNotification("Not enough data (minimum 3 points)", type = "error")
      return()
    }

    values$xtab <- as.vector(x_col)
    values$ytab <- as.vector(y_col)
    values$data_name <- basename(file_path)
    values$fitted <- NULL
    values$curve_lines <- list()
    values$regions <- list()

    updateNumericInput(session, "data_xmin", value = min(values$xtab))
    updateNumericInput(session, "data_xmax", value = max(values$xtab))

    values$manual_knot <- vector()
    kn <- max(input$auto_knot_count, 2) - 1
    values$auto_knot_list <- as.numeric(quantile(values$xtab, probs = (0:(kn)) / (kn)))

    showNotification(paste(
      "File loaded:",
      basename(file_path),
      "-",
      length(x_col),
      "points"
    ),
    type = "success")

  }, error = function(e) {
    showNotification(paste("Read error:", e$message), type = "error")
  })
}
