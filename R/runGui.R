# R/runGui.R

#' Launch the 'BsplineQuantReg' Shiny Interface - Advanced Version
#'
#' Opens an interactive Shiny application for quantile regression using B-splines
#' with shape constraints. This version includes advanced features such as:
#' \itemize{
#'   \item Knot multiplicity management
#'   \item Basis visualization and derivatives
#'   \item Human-readable polynomial display
#'   \item Advanced constraint handling
#' }
#'
#' @details
#' \strong{Version Compatibility:}
#' \itemize{
#'   \item Fully works with \code{BsplineQuantReg >= 0.2.5}
#'   \item Partially works with \code{BsplineQuantReg >= 0.2.4} (some features may be limited)
#'   \item Basic features work with \code{BsplineQuantReg >= 0.2.2}
#' }
#'
#' @param brow Logical. If TRUE, launches the app in the system's default browser.
#' @param rstudio Logical. If TRUE, launches the app in RStudio's viewer pane.
#'        If FALSE, uses the system default.
#' @param host Character. Server address. Default is '127.0.0.1'.
#' @param port Integer. Port to run the app on. Default is 3674.
#'
#' @return Launches a Shiny application. The function returns invisibly when the app stops.
#'
#' @examples
#' \dontrun{
#' # Launch in default browser
#' run_gui2()
#'
#' # Launch in RStudio viewer
#' run_gui2(rstudio = TRUE)
#'
#' # Launch on custom port
#' run_gui2(port = 8080)
#' }
#'
#' @seealso \code{\link{run_gui1}} for the basic version
#' @export
run_gui2 <- function(brow = TRUE, rstudio = FALSE, host = '127.0.0.1', port = 3674) {

  # Trouver le dossier de l'application
  app_dir <- system.file("shiny/app2/", package = "BsplineQuantRegGui")

  # Vérifier que le dossier existe
  if (app_dir == "" || !dir.exists(app_dir)) {
    stop("Advanced Shiny app directory not found. Reinstall the package.")
  }

  # Vérifier que le fichier app.R existe
  app_file <- file.path(app_dir, "app.R")
  if (!file.exists(app_file)) {
    stop("app.R not found in advanced app directory.")
  }

  # Lancer l'application
  if (!brow && !rstudio) {
    # Ni browser ni RStudio - mode headless
    shiny::runApp(app_dir, launch.browser = FALSE, host = host, port = port)
  } else if (brow) {
    # Browser par défaut
    shiny::runApp(app_dir, launch.browser = TRUE, host = host, port = port)
  } else {
    # RStudio viewer
    shiny::runApp(app_dir, host = host, port = port)
  }
}

#' Launch the 'BsplineQuantReg' Shiny Interface - Basic Version
#'
#' Opens an interactive Shiny application for quantile regression using B-splines
#' with shape constraints. This is the basic version with standard features.
#'
#' @details
#' \strong{Features:}
#' \itemize{
#'   \item Standard quantile regression with B-splines
#'   \item Shape constraints (monotonicity, convexity)
#'   \item Region-based constraints
#'   \item Interactive knot placement
#'   \item Data import (CSV)
#'   \item Demo examples
#' }
#'
#' \strong{Not included:}
#' \itemize{
#'   \item Knot multiplicity management
#'   \item Advanced basis visualization
#'   \item Derivative plots
#'   \item Human-readable polynomial display
#' }
#'
#' \strong{Version Compatibility:}
#' \itemize{
#'   \item Fully works with \code{BsplineQuantReg >= 0.2.2}
#' }
#'
#' @param brow Logical. If TRUE, launches the app in the system's default browser.
#' @param rstudio Logical. If TRUE, launches the app in RStudio's viewer pane.
#'        If FALSE, uses the system default.
#' @param host Character. Server address. Default is '127.0.0.1'.
#' @param port Integer. Port to run the app on. Default is 3674.
#'
#' @return Launches a Shiny application. The function returns invisibly when the app stops.
#'
#' @examples
#' \dontrun{
#' # Launch basic version
#' run_gui1()
#' }
#'
#' @seealso \code{\link{run_gui2}} for the advanced version
#' @export
run_gui1 <- function(brow = TRUE, rstudio = FALSE, host = '127.0.0.1', port = 3674) {

  # Trouver le dossier de l'application
  app_dir <- system.file("shiny/app1/", package = "BsplineQuantRegGui")

  # Vérifier que le dossier existe
  if (app_dir == "" || !dir.exists(app_dir)) {
    stop("Basic Shiny app directory not found. Reinstall the package.")
  }

  # Vérifier que le fichier app.R existe
  app_file <- file.path(app_dir, "app.R")
  if (!file.exists(app_file)) {
    stop("app.R not found in basic app directory.")
  }

  # Lancer l'application
  if (!brow && !rstudio) {
    # Ni browser ni RStudio - mode headless
    shiny::runApp(app_dir, launch.browser = FALSE, host = host, port = port)
  } else if (brow) {
    # Browser par défaut
    shiny::runApp(app_dir, launch.browser = TRUE, host = host, port = port)
  } else {
    # RStudio viewer
    shiny::runApp(app_dir, host = host, port = port)
  }
}

#' Launch 'BsplineQuantReg' Shiny Interface (Wrapper Function)
#'
#' Unified launcher for both basic and advanced versions of the application.
#'
#' @param level Character or numeric. Specify which version to launch:
#'          \code{1} or \code{"basic"}: Basic version
#'          \code{2} or \code{"advanced"}: Advanced version (default)
#' @param brow Logical. If TRUE, launches the app in the system's default browser.
#' @param rstudio Logical. If TRUE, launches the app in RStudio's viewer pane.
#' @param host Character. Server address. Default is '127.0.0.1'.
#' @param port Integer. Port to run the app on. Default is 3674.
#'
#' @return Launches the selected Shiny application.
#'
#' @examples
#' \dontrun{
#' # Launch advanced version (default)
#' run_gui()
#' run_gui("advanced")
#' run_gui(2)
#'
#' # Launch basic version
#' run_gui("basic")
#' run_gui(1)
#' }
#'
#' @export
run_gui <- function(level = "advanced", brow = TRUE, rstudio = FALSE,
                    host = '127.0.0.1', port = 3674) {

  # Normaliser le niveau
  level_char <- as.character(level)

  # Détecter la version demandée
  if (level_char %in% c("1", "basic")) {
    # Appel à la version basic
    run_gui1(brow = brow, rstudio = rstudio, host = host, port = port)
  } else if (level_char %in% c("2", "advanced")) {
    # Appel à la version advanced
    run_gui2(brow = brow, rstudio = rstudio, host = host, port = port)
  } else {
    # Niveau invalide - message d'erreur
    stop("Invalid level. Use '1', 'basic', '2', or 'advanced'.")
  }
}
