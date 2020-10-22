#' top_ui UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_top_ui_ui <- function(id){
  ns <- NS(id)
  tagList(
    bs4Dash::bs4DashPage(
      sidebar_collapsed = TRUE,
      sidebar_mini = FALSE,
      body = bs4Dash::bs4DashBody(
        fresh::use_theme(hamiltonCovid19::theme_bs4Dash()),
        bs4Dash::bs4Box(
          width = 12,
          fluidRow(
            bs4Dash::column(
              width = 3,
              shinyWidgets::setSliderColor(c(rep("#b2df8a", 3)), sliderId=c(8,9,10)),
              # Input: Selector for choosing dataset ----
              sliderInput(
                ns("R0"),
                "R0 - average number of infected people for each infected person",
                0.1,
                6,
                1.5,
                step=0.1
              )
            ),
            bs4Dash::column(
              width = 3,
              numericInput(
                inputId = ns("exp"),
                label = "Current number of non-symptomatic spreaders",
                min = 1,
                max = 1e5,
                value = 2000)
            ),
            bs4Dash::column(
              width = 3,
              numericInput(
                inputId = ns("inf"),
                label = "Current number of symptomatic infected cases\n",
                min = 1,
                max = 1e5,
                value = 2000)
            ),
            bs4Dash::column(
              width = 3,
              numericInput(
                inputId = ns("rec"),
                label = "Current total of immune/recovered/dead",
                min = 1,
                max = 1e6,
                value = 300000)
            )
          ),
          hr(),
          fluidRow(
            align = 'center',
            bs4Dash::column(
              width = 4,
              HTML("<div style='font-size:26px;color:black;'><h2 style='font-weight:600;font-size:32px;'>10%</h2> chance it will be extinct by...</div>"),
              br(),
              imageOutput(ns("chance10")) %>% with_load_spinner()
            ),
            bs4Dash::column(
              width = 4,
              HTML("<div style='font-size:26px;color:black;'><h2 style='font-weight:600;font-size:32px;'>50%</h2> chance it will be extinct by...</div>"),
              br(),
              imageOutput(ns("chance50")) %>% with_load_spinner()
            ),
            
            bs4Dash::column(
              width = 4,
              HTML("<div style='font-size:26px;color:black;'><h2 style='font-weight:600;font-size:32px;'>90%</h2> chance it will be extinct by...</div>"),
              br(),
              imageOutput(ns("chance90")) %>%  with_load_spinner()
            )
          )
        )
      )
    )
 
  )
}
    
#' top_ui Server Function
#'
#' @noRd 
mod_top_ui_server <- function(input, output, session){
  ns <- session$ns
 
  re <- reactive({
    validate(
      need(input$exp >= 0, "Make sure the non-symptomatic spreaders value is positive"),
      need(input$exp < 1e5+1, "Current app can only accept non-symptomatic spreaders values less than 100,000"),
      need(input$inf >= 0, "Make sure the symptomatic case value is positive"),
      need(input$inf < 1e5+1, "Current app can only accept symptomatic case values less than 100,000"),
      need(input$rec > 5000, "Make sure the number of recovered/immune/dead is bigger than 5000"),
      need(input$rec < 1000001, "Current app can only accept recovered/immune/dead values less than 1 million")
    )
    
    
    ans <-  run_emulator(input$R0,input$exp,input$inf,input$rec)
    today = as.Date(Sys.time())
    date10_raw = today + ans['q10']
    date50_raw = today + ans['q50']
    date90_raw = today + ans['q90']
    
    list(date10 = list(day = format(date10_raw, '%d'), month  = format(date10_raw, '%B'), year = format(date10_raw, '%Y')),
         date50 = list(day = format(date50_raw, '%d'), month  = format(date50_raw, '%B'), year = format(date50_raw, '%Y')),
         date90 = list(day = format(date90_raw, '%d'), month  = format(date90_raw, '%B'), year = format(date90_raw, '%Y')))
    
  })
  
  output$chance10 <- renderImage({
    
    img <- write_date_calendar(
      img_path = system.file("app/www/blank_cal3.png", package = "hamiltonHowlong"),
      path = tempfile(fileext='.png'),
      re()$date10$month,
      re()$date10$day,
      re()$date10$year
    )
    
    list(src = img,
         contentType = 'image/png',
         width = "80%",
         alt = "This is alternate text")
  }, deleteFile = TRUE)
  
  
  
  output$chance50 <- renderImage({
    
    img <- write_date_calendar(
      img_path = system.file("app/www/blank_cal3.png", package = "hamiltonHowlong"),
      path = tempfile(fileext='.png'),
      re()$date50$month,
      re()$date50$day,
      re()$date50$year
    )
    
    list(src = img,
         contentType = 'image/png',
         width = "80%",
         alt = "This is alternate text")
  }, deleteFile = TRUE)
  
  
  output$chance90 <- renderImage({
    
    img <- write_date_calendar(
      img_path = system.file("app/www/blank_cal3.png", package = "hamiltonHowlong"),
      path = tempfile(fileext='.png'),
      re()$date90$month,
      re()$date90$day,
      re()$date90$year
    )
    
    list(src = img,
         contentType = 'image/png',
         width = "80%",
         alt = "This is alternate text")
  }, deleteFile = TRUE)
}
    
## To be copied in the UI
# mod_top_ui_ui("top_ui_ui_1")
    
## To be copied in the server
# callModule(mod_top_ui_server, "top_ui_ui_1")
 
