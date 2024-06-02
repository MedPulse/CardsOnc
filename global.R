library(shiny)
# library(shinydashboard)

library(bs4Dash)
library(shiny.i18n)
library(shinyWidgets)
library(shiny.fluent)
library(shinycssloaders)
library(dplyr)
library(DT)
library(shinyjs)
library(readr)
library(fresh)

source("body.R")
source("ui.R")
source("result_box.R")



# Language Handling -------------------------------------------------------
i18n <- Translator$new(translation_csvs_path = "data")
i18n$set_translation_language("en")  # Set default language

# data <- reactive({
#   read_csv("data_drugs.csv")
# })

# Importing CSV -----------------------------------------------------------
drug_info <- read.csv("data_drugs.csv")
recommendations <-
  readr::read_csv('recommendations.csv')

surveillance_data <-
  readr::read_csv('surveillance.csv') %>%
  select(-row_n) %>%
  unique()


cardiac_toxicity_data <-
  readr::read_csv('toxicities.csv')


recommendations <-
  readr::read_csv('recommendations.csv')


chemo_agents <-
  list(
    "Anthracycline" = list(
      "Doxorubicin" = "doxorubicin",
      "Bevacizumab" = "bevacizumab",
      "Epirubicin" = "epirubicin",
      "Idarubicin" = "idarubicin",
      "Mitoxantrone" = "mitoxantrone",
      "Trastuzumab" = "trastuzumab"
    ),
    "HER-2 targeted therapies" = list(
      "Pertuzumab" = "pertuzumab",
      "T-DM1" = "t-dm1",
      "Lapatanib" = "lapatanib",
      "Neratinib" = "neratinib"
    ),
    
    
    "VEGF inhibitors" = list(
      "Aflibercept" = "aflibercept",
      "Bevacizumab" = "bevacizumab",
      "Ramucirumab" = "ramucirumab",
      "Axitinib" = "axitinib",
      "Cabozantinib" = "cabozantinib",
      "Lenvatinib" = "lenvatinib",
      "Pazopanib" = "pazopanib",
      "Regorafenib" = "regorafenib",
      "Sorafenib" = "sorafenib",
      "Sunitinib" = "sunitinib",
      "Vandetanib" = "vandetanib"
    ),
    
    
    
    "BRC-ABL inhibitors" = list(
      "Imatinib" = "imatinib",
      "Nilotinib" = "nilotinib",
      "Dasatinib" = "dasatinib",
      "Bosutinib" = "bosutinib",
      "Ponatinib" = "ponatinib"
    ),
    
    
    "Multiple myeloma therapies" = list(
      "Cyclophosphamide" = "cyclophosphamide",
      "Melphalan" = "melphalan",
      "Lenalidomide" = "lenalidomide",
      "Pomalidomide" = "pomalidomide",
      "Thalidomide" = "thalidomide",
      "Bortezomib" = "bortezomib",
      "Carfilzomib" = "carfilzomib",
      "Daratumumab" = "daratumumab",
      "Elotuzumab" = "elotuzumab",
      "Isatuximab" = "isatuximab"
    ),
    
    
    "RAF and MEK inhibitors" = list(
      "Dabrafenib" = "dabrafenib",
      "Encorafenib" = "encorafenib",
      "Vemurafenib" = "vemurafenib",
      "Binimetinib" = "binimetinib",
      "Comimetinib" = "comnimetinib",
      "Trametinib" = "trametinib"
    )
  )

