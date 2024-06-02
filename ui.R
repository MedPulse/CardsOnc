# install.packages("shiny.i18n")
# install.packages("bs4Dash")
# install.packages("shinyWidgets")
# install.packages("shiny.fluent")
# install.packages("fresh")
source("body.R")


# Color Theme -------------------------------------------------------------
custom_colors_theme <- create_theme(
  bs4dash_color(
    blue = "#264653",
    lightblue = "#5798b2",
    navy = "#264653",
    cyan = NULL,
    teal = NULL,
    olive = NULL,
    green = "#2a9d8f",
    lime = NULL,
    orange = "#f4a261",
    yellow = "#e9c46a",
    fuchsia = NULL,
    purple = NULL,
    maroon = NULL,
    red = "#e76f51",
    black = NULL,
    gray_x_light = NULL,
    gray_600 = NULL,
    gray_800 = NULL,
    gray_900 = NULL,
    white = NULL
  )
)


# UI definition
ui <- dashboardPage(

  title = "CardsOnc",
  fullscreen = FALSE,
  help = NULL,
  dark = NULL,
  header = dashboardHeader(
    title = dashboardBrand(
      title = "CardsOnc",
      color = "primary",
      href = "https://www.google.com",
      image = "https://upload.wikimedia.org/wikipedia/en/8/8a/Yale_School_of_Medicine_logo.svg"
    ),
    skin = "light",
    status = "white",
    border = TRUE,
    sidebarIcon = icon("bars"),
    controlbarIcon = icon("th"),
    fixed = FALSE,
    # tags$head(tags$style(
    #   HTML(
    #     "
    #     .main-header {
    #       position: fixed;
    #       width: 100%;
    #       top: 0;
    #       z-index: 1030;
    #       right: 0;
    #       left: 0;
    #     }
    #   .content-wrapper {
    #       padding-top: 50px; /* Adjust this value based on the actual height of your navbar */
    #   }
    #     /* Highly specific CSS targeting and !important for force application */
    #   header.main-header .navbar-nav > .dropdown {
    #     margin-right: -20px !important; /* Negative margin to pull rightUi elements to the left */
    #   }
    #   "
    #   )
    # ))
    # ,
    
    rightUi = tagList(
      tags$li(
        class = "dropdown",
        tags$form(
          style = "width: 150px; margin-top: 0.4rem; margin-right: 20px",
          selectInput(
            inputId = "selected_language",
            label = NULL,
            choices = c("English" = "en", "Spanish" = "es", "Japanese" = "ja", "Chinese"="zh", "Hindi" = "hi", "Marathi" = "mr"),
            selected = i18n$get_key_translation(),
            width = "100%",

          )
        )
      )
    )
    # navbarMenu(
    #   id = "navmenu",
    #   usei18n(i18n),
    #   navbarTab(tabName = "Tab1",i18n$t("Risk Stratification")),
    #   navbarTab(tabName = "Tab2",i18n$t("Educational Information"))
    # )
  ),
  sidebar = dashboardSidebar(disable = FALSE,  # This line disables the sidebar
                             sidebarMenu(
                               menuItem("Risk Stratification", tabName = "Tab1", icon = icon("dashboard")),
                               menuItem("Educational Information", tabName = "Tab2", icon = icon("info"))
                             )),
  footer = dashboardFooter(
    left = a(href = "https://", target = "_blank", "@cardio-onc-group"),
    right = "2024"
  ),
  
  body = body
  
)
