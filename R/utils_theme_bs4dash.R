#' create_theme_css
#'
#' @export
#'
#' @import fresh
create_theme_css <- function() {
  fresh::create_theme(
    fresh::bs4dash_yiq(
      contrasted_threshold = 10,
      text_dark = "#ffffff"
    ),
    fresh::bs4dash_status(
      info = status_para_cor("info"),
      secondary = status_para_cor("secondary"),
      primary = status_para_cor("primary"),
      success = status_para_cor("success"),
      warning = status_para_cor("warning"),
      danger = status_para_cor("danger")
    ),
    fresh::bs4dash_color(
      lightblue = status_para_cor("info"),
      gray_800 = "#495961",
      blue = status_para_cor("primary"),
      green = status_para_cor("success"),
      yellow = status_para_cor("warning")
    ),
    fresh::bs4dash_sidebar_dark(color = "#ffffff",
                                header_color = "#ffffff",
                                bg = status_para_cor("primary") %>% colorspace::darken(0.1)
    ),
    fresh::bs4dash_layout(
      main_bg = "#ffffff"
    )
  )
}

#'
status_para_cor <- function(status) {
  switch (status,
          info = "#8D322C",
          secondary = "#007E8C",
          primary = "#164b53",
          success = "#046874",
          warning = "#b99306",
          danger = "#bf281e")
}

#'
with_load_spinner <- function(ui_element, type = 4, color = status_para_cor("primary"), ...) {
shinycssloaders::withSpinner(ui_element, type = type, color = color, ...)
}