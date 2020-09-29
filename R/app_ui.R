#' The application User-Interface
#' 
#' @param request Internal parameter for `{shiny}`. 
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_ui <- function(request) {
  tagList(
    # Leave this function for adding external resources
    golem_add_external_resources(),
    # List the first level UI elements here 
     # bs4Dash::bs4DashPage(
     #   sidebar_collapsed = TRUE,
     #   sidebar_mini = FALSE,
     #   body = bs4Dash::bs4DashBody(
     #     fresh::use_theme(create_theme_css()),
     #    fluidRow(
     #      align = "center",
     #      column(
     #        3,
     #        sliderInput("R0", "R0 - average number of infected people for each infected person", 0.1, 6, 1.5, step=0.1),
     #        numericInput(inputId = "exp",
     #                     label = "Current number of non-symptomatic spreaders",
     #                     min = 1,
     #                     max = 1e5,
     #                     value = 2000),
     # 
     #        numericInput(inputId = "inf",
     #                     label = "Current number of symptomatic infected cases",
     #                     min = 1,
     #                     max = 1e5,
     #                     value = 2000),
     # 
     #        numericInput(inputId = "rec",
     #                     label = "Current total of immune/recovered/dead",
     #                     min = 1,
     #                     max = 1e6,
     #                     value = 300000)
     # 
     #      ),
     #          bs4Dash::column(
     #            width = 3,
     #            br(),
     #            HTML("<div style='font-size:26px;'><h2 style='font-weight:600;font-size:32px;'>10%</h2> chance it will be extinct by...</div>"),
     #            br(),
     #            imageOutput("chance10") %>% with_load_spinner()
     #          ),
     #          bs4Dash::column(
     #            width = 3,
     #            br(),
     #            HTML("<div style='font-size:26px;'><h2 style='font-weight:600;font-size:32px;'>50%</h2> chance it will be extinct by...</div>"),
     #            br(),
     #            imageOutput("chance50") %>% with_load_spinner
     #          ),
     # 
     #          bs4Dash::column(
     #            width = 3,
     #            br(),
     #            HTML("<div style='font-size:26px;'><h2 style='font-weight:600;font-size:32px;'>90%</h2> chance it will be extinct by...</div>"),
     #            br(),
     #            imageOutput("chance90") %>% with_load_spinner
     #          ) 
     #    ),
     #      
          

          # bs4Dash::bs4Box(
          #   width = 12,
          #   fluidRow(
          #     bs4Dash::column(
          #       width = 3,
          #       shinyWidgets::setSliderColor(c(rep("#b2df8a", 3)), sliderId=c(8,9,10)),
          #       # Input: Selector for choosing dataset ----
          #       sliderInput(
          #         "R0",
          #         "R0 - average number of infected people for each infected person",
          #         0.1,
          #         6,
          #         1.5,
          #         step=0.1
          #       )
          #     ),
          #     bs4Dash::column(
          #       width = 3,
          #       numericInput(
          #         inputId = "exp",
          #         label = "Current number of non-symptomatic spreaders",
          #         min = 1,
          #         max = 1e5,
          #         value = 2000)
          #     ),
          #     bs4Dash::column(
          #       width = 3,
          #       numericInput(
          #         inputId = "inf",
          #         label = "Current number of symptomatic infected cases\n",
          #         min = 1,
          #         max = 1e5,
          #         value = 2000)
          #     ),
          #     bs4Dash::column(
          #       width = 3,
          #       numericInput(
          #         inputId = "rec",
          #         label = "Current total of immune/recovered/dead",
          #         min = 1,
          #         max = 1e6,
          #         value = 300000)
          #     )
          #   ),
          #   hr(),
          #   fluidRow(
          #     align = 'center',
          #     bs4Dash::column(
          #       width = 4,
          #       HTML("<div style='font-size:26px;'><h2 style='font-weight:600;font-size:32px;'>10%</h2> chance it will be extinct by...</div>"),
          #       br(),
          #       imageOutput("chance10") %>% with_load_spinner()
          #     ),
          #     bs4Dash::column(
          #       width = 4,
          #       HTML("<div style='font-size:26px;'><h2 style='font-weight:600;font-size:32px;'>50%</h2> chance it will be extinct by...</div>"),
          #       br(),
          #       imageOutput("chance50") %>% with_load_spinner()
          #     ),
          # 
          #     bs4Dash::column(
          #       width = 4,
          #       HTML("<div style='font-size:26px;'><h2 style='font-weight:600;font-size:32px;'>90%</h2> chance it will be extinct by...</div>"),
          #       br(),
          #       imageOutput("chance90") %>%  with_load_spinner()
          #     )
          #   )
          # )
  #        )
  #     )
  #   
  # )
  
    mod_side_ui_ui("side_ui")
    #mod_top_ui_ui("top_ui")
  )

    
}

#' Add external Resources to the Application
#' 
#' This function is internally used to add external 
#' resources inside the Shiny application. 
#' 
#' @import shiny
#' @importFrom golem add_resource_path activate_js favicon bundle_resources
#' @noRd
golem_add_external_resources <- function(){
  
  add_resource_path(
    'www', app_sys('app/www')
  )
 
  tags$head(
    favicon(),
    bundle_resources(
      path = app_sys('app/www'),
      app_title = 'hamiltonHowlong'
    )
    # Add here other external resources
    # for example, you can add shinyalert::useShinyalert() 
  )
}

