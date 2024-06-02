very_high_risk_info <- renderInfoBox({
  infoBox(
    title = i18n$t("Risk Level"),
    color = "danger",
    icon = icon("triangle-exclamation", lib = "font-awesome"),
    value = i18n$t("VERY HIGH RISK")
    
  )
})


very_high_risk_recommendations<- renderValueBox({
  valueBox(
    value = i18n$t("RECOMMENDATIONS"),
    icon = icon("triangle-exclamation", lib = "font-awesome"),
    
    subtitle = tags$div(
      tags$ul(
        tags$li(
          i18n$t("Cardiology referral"),
          tags$i(class = "fa-solid fa-circle fa-2xs", style = "color: #54B685ff; text-shadow: 1px 1px 5px #000000;")
        ),
        tags$li(
          i18n$t("Discussion of the risks/benefits balance of cardiotoxic anticancer treatment in a multidisciplinary manner"),
          tags$i(class = "fa-solid fa-circle fa-2xs", style = "color: #54B685ff; text-shadow: 1px 1px 5px #000000;")
        ),
        tags$li(
          i18n$t("Cardioprotective strategies"),
          tags$i(class = "fa-solid fa-circle fa-2xs", style = "color: #F9CA38ff; text-shadow: 1px 1px 5px #000000;")
        )
      ),
      tags$hr(),
      tags$ul(
        tags$li(
          i18n$t("Communicate the CV toxicity risk assessment results to the patient"),
          tags$i(class = "fa-solid fa-circle fa-2xs", style = "color: #54B685ff; text-shadow: 1px 1px 5px #000000;")
        ),
        tags$li(
          i18n$t("Educate patients regarding risks and protective healthy lifestyle"),
          tags$i(class = "fa-solid fa-circle fa-2xs", style = "color: #54B685ff; text-shadow: 1px 1px 5px #000000;")
        ),
        tags$li(
          i18n$t("Management of CVRF and CVD according to ESC guidelines"),
          tags$i(class = "fa-solid fa-circle fa-2xs", style = "color: #54B685ff; text-shadow: 1px 1px 5px #000000;")
        )
      )
    ),
    
    # icon = icon("triangle-exclamation", lib = "font-awesome"),
    color = "danger",
    href = NULL,
    footer = tags$p(
      i18n$t("Class Recommendations:"),
      tags$br(),
      tags$i(class = "fa-solid fa-circle fa-2xs", style = "color: #54B685ff; text-shadow: 1px 1px 5px #000000;"),
      " = Class I",
      tags$i(class = "fa-solid fa-circle fa-2xs", style = "color: #F9CA38ff; text-shadow: 1px 1px 5px #000000;"),
      "  = Class IIa",
      tags$i(class = "fa-solid fa-circle fa-2xs", style = "color: #EB8B34ff; text-shadow: 1px 1px 5px #000000;"),
      "  = Class IIb"
    ),
    gradient = TRUE,
    elevation = 2
  )
})



# High Risk ---------------------------------------------------------------
high_risk_info <- renderInfoBox({
  infoBox(
    title = "Risk Level",
    color = "danger",
    icon = icon("triangle-exclamation", lib = "font-awesome"),
    value = i18n$t("HIGH RISK")
  )
})

high_risk_recommendations <- renderValueBox({
  valueBox(
    value = i18n$t("RECOMMENDATIONS"),
    icon = icon("triangle-exclamation", lib = "font-awesome"),
    
    subtitle = tags$div(
      tags$ul(
        tags$li(
          i18n$t("Cardiology referral"),
          tags$i(class = "fa-solid fa-circle fa-2xs", style = "color: #54B685ff; text-shadow: 1px 1px 5px #000000;")
        ),
        tags$li(
          i18n$t("Discussion of the risks/benefits balance of cardiotoxic anticancer treatment in a multidisciplinary manner"),
          tags$i(class = "fa-solid fa-circle fa-2xs", style = "color: #54B685ff; text-shadow: 1px 1px 5px #000000;")
        ),
        tags$li(
          i18n$t("Cardioprotective strategies"),
          tags$i(class = "fa-solid fa-circle fa-2xs", style = "color: #F9CA38ff; text-shadow: 1px 1px 5px #000000;")
        )
      ),
      tags$hr(),
      tags$ul(
        tags$li(
          i18n$t("Communicate the CV toxicity risk assessment results to the patient"),
          tags$i(class = "fa-solid fa-circle fa-2xs", style = "color: #54B685ff; text-shadow: 1px 1px 5px #000000;")
        ),
        tags$li(
          i18n$t("Educate patients regarding risks and protective healthy lifestyle"),
          tags$i(class = "fa-solid fa-circle fa-2xs", style = "color: #54B685ff; text-shadow: 1px 1px 5px #000000;")
        ),
        tags$li(
          i18n$t("Management of CVRF and CVD according to ESC guidelines"),
          tags$i(class = "fa-solid fa-circle fa-2xs", style = "color: #54B685ff; text-shadow: 1px 1px 5px #000000;")
        )
      )
    ),
    
    # icon = icon("triangle-exclamation", lib = "font-awesome"),
    color = "danger",
    href = NULL,
    footer = tags$p(
      i18n$t("Class Recommendations:"),
      tags$br(),
      tags$i(class = "fa-solid fa-circle fa-2xs", style = "color: #54B685ff; text-shadow: 1px 1px 5px #000000;"),
      " = Class I",
      tags$i(class = "fa-solid fa-circle fa-2xs", style = "color: #F9CA38ff; text-shadow: 1px 1px 5px #000000;"),
      "  = Class IIa",
      tags$i(class = "fa-solid fa-circle fa-2xs", style = "color: #EB8B34ff; text-shadow: 1px 1px 5px #000000;"),
      "  = Class IIb"
    ),
    gradient = TRUE,
    elevation = 2
  )
})



# Moderate Risk -----------------------------------------------------------
moderate_risk_info <- renderInfoBox({
  infoBox(
    title = "Risk Level",
    color = "warning",
    icon = icon("triangle-exclamation", lib = "font-awesome"),
    value = "MODERATE RISK"
  )
})

moderate_risk_recommendations <- renderValueBox({
  valueBox(
    value = "RECOMMENDATIONS",
    icon = icon("triangle-exclamation", lib = "font-awesome"),
    
    subtitle = tags$div(
      tags$ul(
        tags$li("Closer oncology follow-up"),
        tags$li(
          "Cardiology referral if CV toxicity develops",
          tags$i(class = "fa-solid fa-circle fa-2xs", style = "color: #54B685ff; text-shadow: 1px 1px 5px #000000;")
        ),
        tags$li(
          "Cardiology referral",
          tags$i(class = "fa-solid fa-circle fa-2xs", style = "color: #EB8B34ff; text-shadow: 1px 1px 5px #000000;")
        )
      ),
      tags$hr(),
      tags$ul(
        tags$li(
          "Communicate the CV toxicity risk assessment results to the patient",
          tags$i(class = "fa-solid fa-circle fa-2xs", style = "color: #54B685ff; text-shadow: 1px 1px 5px #000000;")
        ),
        tags$li(
          "Educate patients regarding risks and protective healthy lifestyle",
          tags$i(class = "fa-solid fa-circle fa-2xs", style = "color: #54B685ff; text-shadow: 1px 1px 5px #000000;")
        ),
        tags$li(
          "Management of CVRF and CVD according to ESC guidelines",
          tags$i(class = "fa-solid fa-circle fa-2xs", style = "color: #54B685ff; text-shadow: 1px 1px 5px #000000;")
        )
      )
    ),
    
    # icon = icon("triangle-exclamation", lib = "font-awesome"),
    color = "warning",
    href = NULL,
    footer = tags$p(
      "Class Recommendations:",
      tags$br(),
      tags$i(class = "fa-solid fa-circle fa-2xs", style = "color: #54B685ff; text-shadow: 1px 1px 5px #000000;"),
      " = Class I",
      tags$i(class = "fa-solid fa-circle fa-2xs", style = "color: #F9CA38ff; text-shadow: 1px 1px 5px #000000;"),
      "  = Class IIa",
      tags$i(class = "fa-solid fa-circle fa-2xs", style = "color: #EB8B34ff; text-shadow: 1px 1px 5px #000000;"),
      "  = Class IIb"
    ),
    gradient = TRUE,
    elevation = 2
  )
})


# Low Risk ----------------------------------------------------------------

low_risk_info <- renderInfoBox({
  infoBox(
    title = i18n$t("Risk Level"),
    color = "success",
    icon = icon("triangle-exclamation", lib = "font-awesome"),
    value = i18n$t("LOW RISK")
  )
})

low_risk_recommendations <- renderValueBox({
  valueBox(
    value = i18n$t("RECOMMENDATIONS"),
    icon = icon("triangle-exclamation", lib = "font-awesome"),
    
    subtitle = tags$div(
      tags$ul(
        tags$li(i18n$t("Routine oncology follow-up")),
        tags$li(
          i18n$t("Cardiology referral if CV toxicity develops"),
          tags$i(class = "fa-solid fa-circle fa-2xs", style = "color: #54B685ff; text-shadow: 1px 1px 5px #000000;")
        ),
        tags$li(
          i18n$t("Proceed to anticancer therapy without delay (for low CV toxicity)"),
          tags$i(class = "fa-solid fa-circle fa-2xs", style = "color: #54B685ff; text-shadow: 1px 1px 5px #000000;")
        )
      ),
      tags$hr(),
      tags$ul(
        tags$li(
          i18n$t("Communicate the CV toxicity risk assessment results to the patient"),
          tags$i(class = "fa-solid fa-circle fa-2xs", style = "color: #54B685ff; text-shadow: 1px 1px 5px #000000;")
        ),
        tags$li(
          i18n$t("Educate patients regarding risks and protective healthy lifestyle"),
          tags$i(class = "fa-solid fa-circle fa-2xs", style = "color: #54B685ff; text-shadow: 1px 1px 5px #000000;")
        ),
        tags$li(
          i18n$t("Management of CVRF and CVD according to ESC guidelines"),
          tags$i(class = "fa-solid fa-circle fa-2xs", style = "color: #54B685ff; text-shadow: 1px 1px 5px #000000;")
        )
      )
    )
    ,
    
    # icon = icon("triangle-exclamation", lib = "font-awesome"),
    color = "success",
    href = NULL,
    footer = tags$p(
      i18n$t("Class Recommendations:"),
      tags$br(),
      tags$i(class = "fa-solid fa-circle fa-2xs", style = "color: #54B685ff; text-shadow: 1px 1px 5px #000000;"),
      " = Class I",
      tags$i(class = "fa-solid fa-circle fa-2xs", style = "color: #F9CA38ff; text-shadow: 1px 1px 5px #000000;"),
      "  = Class IIa",
      tags$i(class = "fa-solid fa-circle fa-2xs", style = "color: #EB8B34ff; text-shadow: 1px 1px 5px #000000;"),
      "  = Class IIb"
    ),
    gradient = TRUE,
    elevation = 2
  )
})
