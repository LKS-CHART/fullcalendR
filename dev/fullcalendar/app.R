#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
# library(fullcalendR)
pkgload::load_all()

# Define UI for application that draws a histogram
ui <- fluidPage(

    tags$head(
        tags$style(HTML("
      #box {
               position: fixed;
    top: 5vw;
    left: 35vw;
    right: 5vw;
    bottom: 5vw;
      }

    "))
    ),

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
            selectInput("resident",
                        label = "Resident",
                        choices = c("Joe", "Paul", "Anne", "Maria"),
                        selected = NULL),
            selectInput("event_type",
                        label = "Event type",
                        choices = c("vacation", "academic", "holiday"),
                        selected = "academic")
        ),

        # Show a plot of the generated distribution
        mainPanel(
            div(id = "box",
                fullcalendarOutput("calendar")
            )
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output, session) {

    data <- data.frame(title = paste("Event", 1:4),
                       start = c("2020-05-03 00:00", "2020-05-01", "2020-05-03", "2020-05-15"),
                       end = c("2020-05-05 01:00", "2020-05-04", "2020-05-03", "2020-05-18"),
                       color = c("red", "blue", "yellow", "green"),
                       id = c("event_id1", "event_id2", "event_id3", "event_id4"),
                       className = c("vacation", "academic", "holiday", "vacation"),
                       rendering = c("", "", "background", ""),
                       resident = c("Joe", "Paul", "Anne", "Maria"))


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
                                'Shiny.setInputValue("start_date", info.event.start)',
                                'Shiny.setInputValue("end_date", info.event.end)',
                                'Shiny.setInputValue("resident", info.event.extendedProps.resident)',
                                'Shiny.setInputValue("event_type", info.event.classNames);}'
                            ),
                            eventLimit = TRUE,
                            eventLimitClick = "popover",
                            editable = TRUE
            )
        )
    })

    observe({
        message(input$start_date)
        message(input$end_date)
        message(input$event_type)
        message(input$resident)
        updateDateInput(session,
                        inputId = "start_date",
                        value = input$start_date)

        updateDateInput(session,
                        inputId = "end_date",
                        value = input$end_date)


        updateSelectInput(session,
                          inputId = "resident",
                          selected = input$resident)

        updateSelectInput(session,
                          inputId = "event_type",
                          selected = input$event_type)


    })
}

# Run the application
shinyApp(ui = ui, server = server)
