create_new_region<-function(x_vals)
{
  if (length(x_vals) >= 2) {
      xmin <- min(x_vals, na.rm = TRUE)
      xmax <- max(x_vals, na.rm = TRUE)
      updateNumericInput(session, "region_xmin", value = round(xmin, 3))
      updateNumericInput(session, "region_xmax", value = round(xmax, 3))
      values$selecting_region <- FALSE
      updateActionButton(session, "start_selection", label = "Select")
      showNotification(paste("Rectangle selected. Click 'Add region' to create it."),
                       type = "message", duration = 5)
    }
}


add_region<-function()
{
  req(values$xtab, values$knot)
  xmin <- input$region_xmin
  xmax <- input$region_xmax
  if (xmin >= xmax) {
    showNotification("X min < X max", type = "warning")
    return()
  }
  values$region_id <- values$region_id + 1
  region <- list(
    id = values$region_id,
    xmin = xmin,
    xmax = xmax,
    monot = as.numeric(input$region_monot),
    conv = as.numeric(input$region_conv),
    der3 = as.numeric(input$region_der3)
  )
  values$regions <- c(values$regions, list(region))
  values$selected_region_id <- values$region_id  # Selectionner la nouvelle région
  showNotification(paste("Region added: [", round(xmin, 3), ", ",
                         round(xmax, 3), "]"), type = "message")
}


update_region<-function()
{
  if (!is.null(values$selected_region_id)) {
    idx <- which(sapply(values$regions, function(r)
      r$id == values$selected_region_id))
    if (length(idx) > 0) {
      values$regions[[idx]]$xmin <- input$region_xmin
      values$regions[[idx]]$xmax <- input$region_xmax
      values$regions[[idx]]$monot <- as.numeric(input$region_monot)
      values$regions[[idx]]$conv <- as.numeric(input$region_conv)
      values$regions[[idx]]$der3 <- as.numeric(input$region_der3)
      showNotification("Region updated", type = "message")
    }
  } else {
    showNotification("Select a region first", type = "warning")
  }
}


update_region_fields <- function(xmin, xmax) {
  if (is.null(xmin) ||
      is.null(xmax) || is.na(xmin) || is.na(xmax))
    return()
  if (xmin >= xmax) {
    showNotification("X min must be less than X max", type = "warning")
    return()
  }
  updateNumericInput(session, "region_xmin", value = round(xmin, 3))
  updateNumericInput(session, "region_xmax", value = round(xmax, 3))
}
