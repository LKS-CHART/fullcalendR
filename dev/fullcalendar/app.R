#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(fullcalendR)


# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Old Faithful Geyser Data"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            dateInput("start_date",
                      "Start date",
                      value = NULL),
            dateInput("end_date",
                      "End date",
                      value = NULL),
            selectInput("event_type",
                        label = "Event type",
                        choices = c("vacation", "academic", "holiday"),
                        selected = "academic")
        ),

        # Show a plot of the generated distribution
        mainPanel(
            fullcalendarOutput("calendar")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

    data <- data.frame(title = paste("Event", 1:4),
                       start = c("2020-05-03 00:00", "2020-05-01", "2020-05-03", "2020-05-15"),
                       end = c("2020-05-05 01:00", "2020-05-04", "2020-05-03", "2020-05-18"),
                       color = c("red", "blue", "yellow", "green"),
                       id = c("event_id1", "event_id2", "event_id3", "event_id4"),
                       className = c("vacation", "academic", "holiday", "vacation"))


    output$calendar <- renderFullcalendar({
        fullcalendar(
            data = data,
            settings = list(selectable = TRUE,
                            dateClick = htmlwidgets::JS(
                              'function(info) {',
                              'Shiny.setInputValue("start_date", info.dateStr)',
                              'Shiny.setInputValue("end_date", info.dateStr);}'
                            ),
                            select = htmlwidgets::JS(
                              'function(info) {',
                              'Shiny.setInputValue("start_date", info.startStr)',
                              'Shiny.setInputValue("end_date", info.endStr);}'
                            ),
                            eventClick = htmlwidgets::JS(
                                'function(info) {',
                                'Shiny.setInputValue("event_type", info.event.classNames);}'
                            ),
                            eventLimit = TRUE,
                            eventLimitClick = "popover"
            )
        )
    })

    observe({
        message(input$start_date)
        message(input$end_date)
        message(input$event_type)
    })
}

# Run the application
shinyApp(ui = ui, server = server)
