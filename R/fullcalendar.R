#' <Add Title>
#'
#' <Add Description>
#'
#' @import htmlwidgets
#'
#' @export
fullcalendar <- function(data = NULL, settings = list(), width = NULL, height = NULL, elementId = NULL) {
  settings$events <- data
  attr(settings, 'TOJSON_ARGS') <- list(dataframe = "rows")

  # create widget
  htmlwidgets::createWidget(
    name = 'fullcalendar',
    x = settings,
    width = width,
    height = height,
    package = 'fullcalendR',
    elementId = elementId
  )
}


#' Shiny bindings for fullcalendar
#'
#' Output and render functions for using fullcalendar within Shiny
#' applications and interactive Rmd documents.
#'
#' @param outputId output variable to read from
#' @param width,height Must be a valid CSS unit (like \code{'100\%'},
#'   \code{'400px'}, \code{'auto'}) or a number, which will be coerced to a
#'   string and have \code{'px'} appended.
#' @param expr An expression that generates a fullcalendar
#' @param env The environment in which to evaluate \code{expr}.
#' @param quoted Is \code{expr} a quoted expression (with \code{quote()})? This
#'   is useful if you want to save an expression in a variable.
#'
#' @name fullcalendar-shiny
#'
#' @export
fullcalendarOutput <- function(outputId, width = '100%', height = '400px'){
  htmlwidgets::shinyWidgetOutput(outputId, 'fullcalendar', width, height, package = 'fullcalendR')
}

#' @rdname fullcalendar-shiny
#' @export
renderFullcalendar <- function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) { expr <- substitute(expr) } # force quoted
  htmlwidgets::shinyRenderWidget(expr, fullcalendarOutput, env, quoted = TRUE)
}
