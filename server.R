rf_table <-
  readr::read_csv('risk_factors.csv')


# Server logic
function(input, output, session) {
  
  
  observeEvent(input$tab, {
    updateTabsetPanel(session, inputId = "mybox2", input$tab)
  })



  # Language Handling -------------------------------------------------------
  observeEvent(input$selected_language, {
    i18n$set_translation_language(input$selected_language)
    update_lang(input$selected_language)
  })
  
  
  # # Dynamically generate the table of contents
  # output$toc <- renderUI({
    # tags$ul(
    #   lapply(seq_len(nrow(data)), function(i) {
    #     tags$li(a(href = sprintf("#card-%d", i), data$drug_name[i]))
    #   })
    # )
  # })
  
  output$toc <- renderUI({
    tags$ul(
      lapply(seq_len(nrow(drug_info)), function(i) {
        card <- drug_info[i, ]
        tags$li(
          a(href = sprintf("#card-%d", i), card$drug_name),
          # tags$ul(
          #   tags$li(a(href = sprintf("#def-%d", i), "Definition")),
          #   tags$li(a(href = sprintf("#mech-%d", i), "MOA")),
          #   tags$li(a(href = sprintf("#type-%d", i), "Types")),
          #   tags$li(a(href = sprintf("#toxic-%d", i), "Toxicity")),
          #   tags$li(a(href = sprintf("#risk-%d", i), "Risk Strat")),
          #   tags$li(a(href = sprintf("#surv-%d", i), "Surveillance")),
          #   tags$li(a(href = sprintf("#diag-%d", i), "Dx/Mgmt"))
          # )
        )
      })
    )
  })
  
  
  
  
  output$cards <- renderUI({
    fluidRow(
      
      lapply(seq_len(nrow(drug_info)), function(i) {

        card <- drug_info[i, ]

        box(
          id = sprintf("card-%d", i),
          title = i18n$t(card$drug_name),
          collapsible = TRUE,
          collapsed = TRUE,
          solidHeader = TRUE,
          status = "primary",
          width = 12,
          div(id = sprintf("def-%d", i), Separator(h3(i18n$t("Definition"))),
              HTML(i18n$t(as.character(card$definition)))
          ),
          div(id = sprintf("mech-%d", i), Separator(h3(i18n$t("Mechanism of Action"))),
          HTML(i18n$t(card$mechanism_of_action))),
          div(id = sprintf("type-%d", i), Separator(h3(i18n$t("Types"))),
          HTML(i18n$t(card$types))),
          div(id = sprintf("toxic-%d", i), Separator(h3(i18n$t("Cardiovascular Toxicity"))),
          HTML(i18n$t(card$cardiovascular_toxicity))),
          div(id = sprintf("risk-%d", i), Separator(h3(i18n$t("Risk Stratification"))),
          HTML(i18n$t(card$risk_stratification))),
          div(id = sprintf("surv-%d", i), Separator(h3(i18n$t("Surveillance"))),
          HTML(i18n$t(card$surveillance))),
          div(id = sprintf("diag-%d", i), Separator(h3(i18n$t("Diagnosis/Management of Cardiovascular Toxicities"))),
          HTML(i18n$t(card$diagnosis_toxicity)))
        )
      })
    )
  })
  
  # Add JavaScript to enable smooth scrolling
  runjs("
    $(document).on('click', '#floating-toc a', function(event) {
      event.preventDefault();
      var target = $(this).attr('href');
      var offset = 80;  // Offset to lower the scroll position to show the card title
      $('html, body').animate({
        scrollTop: $(target).offset().top - offset
      }, 1000);
    });
  ")


  
  

  observe({
    updateAwesomeCheckboxGroup(session,
                               "risk_factors",
                               i18n$t("Select all that apply"),
                               choices = setNames(
                                 c(
                                   "smoke",
                                   "obese",
                                   "htn",
                                   "hld",
                                   "dm",
                                   "ckd",
                                   "urine_pt",
                                   "thrombophilia",
                                   "NULL"
                                 ),
                                 i18n$t(
                                   c(
                                     "Significant smoking history or current smoker",
                                     "BMI ≥ 30 kg/m2",
                                     "Hypertension",
                                     "Hyperlipidemia",
                                     "Diabetes Mellitus",
                                     "Chronic kidney disease",
                                     "Proteinuria",
                                     "Family history of thrombophilia",
                                     "None of the above"
                                   )
                                 )
                               ))


    updateAwesomeCheckboxGroup(session,
                               "cvd",
                               i18n$t("Select all that apply"),
                               choices = setNames(
                                 c(
                                   "hf_cm",
                                   "vhd",
                                   "mi_pci_cabg",
                                   "angina",
                                   "avd",
                                   "abi",
                                   "ph",
                                   "tki",
                                   "dvt_pe",
                                   "arrhythmia",
                                   "amyloid",
                                   "pi_tox",
                                   "imid_tox",
                                   "lvh"
                                 ),
                                 i18n$t(
                                   c(
                                     "Heart failure or cardiomyopathy",
                                     "Severe valvular heart disease",
                                     "Myocardial infarction, PCI, or CABG",
                                     "Stable angina",
                                     "Arterial Vascular Disease",
                                     "Abnormal ankle-brachial pressure index",
                                     "Pulmonary hypertension",
                                     "Arterial thrombosis with TKI",
                                     "Venous thrombosis or pulmonary embolism",
                                     "Arrhythmia",
                                     "Cardiac Amyloidosis",
                                     "Prior Proteosome Inhibitor toxicity",
                                     "Prior immunomodulatory cardiovascular toxicity",
                                     "Left ventricular hypertrophy"
                                   )
                                 )
                               ))

    updateAwesomeRadio(session, "qtc", i18n$t("QTc Length"),
                       choices = setNames(c(
                         "mid_qtc",
                         "mid_qtc",
                         "long_qtc",
                         "nl_qtc"
                       ),
                       i18n$t(
                         c(
                           "450 ≤ QTc ≤ 480 ms (men)",
                           "460 ≤ QTc ≤ 480 ms (women)",
                           "QTc ≥ 480 ms",
                           "None of the above"
                         )
                       )))

    updateAwesomeCheckboxGroup(session,
                               "bcf",
                               i18n$t("Select all that apply"),
                               choices = setNames(
                                 c(
                                   "elev_trop",
                                   "elev_np"
                                 ),
                                 i18n$t(
                                   c(
                                     "Elevated cardiac troponin",
                                     "Elevated natriuretic peptide"
                                   )
                                 )
                               ))

    updateAwesomeCheckboxGroup(session,
                               "ctx",
                               i18n$t("Current and Prior Cancer Treatments"),
                               choices = setNames(
                                 c(
                                   "dex",
                                   "ant_her2"
                                 ),
                                 i18n$t(
                                   c(
                                     "Dexamethasone > 160 mg/month",
                                     "Anthracycline before HER2-targeted therapy"
                                   )
                                 )
                               ))

    updateAwesomeCheckboxGroup(session,
                               "exp",
                               i18n$t("Previous exposure to"),
                               choices = setNames(
                                 c(
                                   "ant",
                                   "tras",
                                   "rt",
                                   "non_ant"
                                 ),
                                 i18n$t(
                                   c(
                                     "Anthracycline",
                                     "Trastuzumab",
                                     "Radiation to left chest or mediastinum",
                                     "Non-anthracycline chemotherapy"
                                   )
                                 )
                               ))
  })





  # Educational Card Display ------------------------------------------------
  # observe({
  #   lapply(seq_len(nrow(drug_info)), function(i) {
  #     output[[paste0("medication_info_", i)]] <- renderUI({
  #       drug <- drug_info[i, ]
  # 
  #       div(
  #         class = "card",
  #         h2(drug$drug_name, id = gsub(" ", "", drug$drug_name)),
  #         Separator(h3("Definition")),
  #         HTML(drug$definition),
  #         Separator(h3("Mechanism of Action")),
  #         HTML(drug$mechanism_of_action),
  #         Separator(h3("Types")),
  #         HTML(drug$types),
  #         Separator(h3("Cardiovascular Toxicity")),
  #         HTML(drug$cardiovascular_toxicity),
  #         Separator(h3("Risk Stratification")),
  #         HTML(drug$risk_stratification),
  #         Separator(h3("Surveillance")),
  #         HTML(drug$surveillance),
  #         Separator(h3(
  #           "Dignosis/Management of Cardiovascular Toxcities"
  #         )),
  #         HTML(drug$diagnosis_toxicity)
  #       )
  #     })
  #   })
  # })
  # 



  # Risk Stratification Calculations ----------------------------------------
  risk_list <-
    reactiveValues() # Object will hold values for entries

  observeEvent(input$drug_name, {
    drug_name <- tolower(input$drug_name)
    for (category in names(chemo_agents)) {
      if (drug_name
          %in% unlist(chemo_agents[[category]])) {
        risk_list[["a"]] <- category
        break
      }
    }
  })

  toggle_happened <- reactiveVal(FALSE)
  


  # Observe Events with Submit Button Pressed -------------------------------
  observeEvent(input$submit, {
    risk_list[["b"]] <- input$drug_name
    risk_list[["c"]] <- input$risk_factors
    risk_list[["d"]] <- input$age
    risk_list[["e"]] <- input$cvd
    risk_list[["f"]] <- input$qtc
    risk_list[["g"]] <- input$bcf
    risk_list[["h"]] <- input$ef
    risk_list[["i"]] <- input$ctx
    risk_list[["j"]] <- input$exp

    

    
    if (!toggle_happened()) {  # Check if toggle has not yet happened
      toggle(id = "instructions_title")
      toggle(id = "instructions")
      toggle(id = "results_title")
      toggle(id = "tab_toggle")
      
      toggle_happened(TRUE)  # Set the toggle as happened
    }
    
    
    count <-
      reactiveVal(0) # count - keeps track of total risk level
    counter <-
      reactiveValues(
        # counter - keeps track of low, mod, high and very high
        'a' = 0,
        'b' = 0,
        'c' = 0,
        'd' = 0
      )


    # Risk Evaluator
    if (length(input$risk_factors) != 0) {
      for (i in input$risk_factors) {
        temp_number <- (rf_table[rf_table$risk_type == i, risk_list[["a"]]])

        if (temp_number == 1) {
          counter$a <- counter$a + as.numeric(temp_number)
        }
        else if (temp_number == 2) {
          counter$b <- counter$b + as.numeric(temp_number)
        }

        else if (temp_number == 3) {
          counter$c <- counter$c + as.numeric(temp_number)
        }

        else if (temp_number == 4) {
          counter$d <- counter$d + as.numeric(temp_number)
        }
      }
    }

    # Age Evaluator
    if (!is.null(input$age)) {
      temp_number <-
        (rf_table[rf_table$risk_type == input$age, risk_list[["a"]]])
      if (temp_number == 1) {
        counter$a <- counter$a + as.numeric(temp_number)
      }
      else if (temp_number == 2) {
        counter$b <- counter$b + as.numeric(temp_number)
      }
      else if (temp_number == 3) {
        counter$c <- counter$c + as.numeric(temp_number)
      }
      else if (temp_number == 4) {
        counter$d <- counter$d + as.numeric(temp_number)
      }
    }

    # Cardiovascular disease input - evaluates risk factor for CVD
    if (length(input$cvd) != 0) {
      for (i in input$cvd) {
        temp_number <- (rf_table[rf_table$risk_type == i, risk_list[["a"]]])
        if (temp_number == 1) {
          counter$a <- counter$a + as.numeric(temp_number)
        }
        else if (temp_number == 2) {
          counter$b <- counter$b + as.numeric(temp_number)
        }
        else if (temp_number == 3) {
          counter$c <- counter$c + as.numeric(temp_number)
        }
        else if (temp_number == 4) {
          counter$d <- counter$d + as.numeric(temp_number)
        }
      }
    }

    # qtc input - evalutes risk factor of qtc selected
    if (!is.null(input$qtc)) {
      temp_number <-
        (rf_table[rf_table$risk_type == input$qtc, risk_list[["a"]]])
      if (temp_number == 1) {
        counter$a <- counter$a + as.numeric(temp_number)
      }
      else if (temp_number == 2) {
        counter$b <- counter$b + as.numeric(temp_number)
      }
      else if (temp_number == 3) {
        counter$c <- counter$c + as.numeric(temp_number)
      }
      else if (temp_number == 4) {
        counter$d <- counter$d + as.numeric(temp_number)
      }
    }

    # trop and np input - evaluates risk level of trop and np levels
    if (length(input$bcf) != 0) {
      for (i in input$bcf) {
        temp_number <- (rf_table[rf_table$risk_type == i, risk_list[["a"]]])
        if (temp_number == 1) {
          counter$a <- counter$a + as.numeric(temp_number)
        }
        else if (temp_number == 2) {
          counter$b <- counter$b + as.numeric(temp_number)
        }
        else if (temp_number == 3) {
          counter$c <- counter$c + as.numeric(temp_number)
        }
        else if (temp_number == 4) {
          counter$d <- counter$d + as.numeric(temp_number)
        }
      }
    }

    # EF input - evaluates risk level based on EF input
    if (!is.null(input$ef)) {
      temp_number <-
        (rf_table[rf_table$risk_type == input$ef, risk_list[["a"]]])
      if (temp_number == 1) {
        counter$a <- counter$a + as.numeric(temp_number)
      }
      else if (temp_number == 2) {
        counter$b <- counter$b + as.numeric(temp_number)
      }
      else if (temp_number == 3) {
        counter$c <- counter$c + as.numeric(temp_number)
      }
      else if (temp_number == 4) {
        counter$d <- counter$d + as.numeric(temp_number)
      }
    }

    # Current input - evalutes risk level based on current tx
    if (length(input$ctx) != 0) {
      for (i in input$ctx) {
        temp_number <- (rf_table[rf_table$risk_type == i, risk_list[["a"]]])
        if (temp_number == 1) {
          counter$a <- counter$a + as.numeric(temp_number)
        }
        else if (temp_number == 2) {
          counter$b <- counter$b + as.numeric(temp_number)
        }
        else if (temp_number == 3) {
          counter$c <- counter$c + as.numeric(temp_number)
        }
        else if (temp_number == 4) {
          counter$d <- counter$d + as.numeric(temp_number)
        }
      }
    }

    # Prior input - evaluates risk level based on prior tx
    if (length(input$exp) != 0) {
      for (i in input$exp) {
        temp_number <- (rf_table[rf_table$risk_type == i, risk_list[["a"]]])
        if (temp_number == 1) {
          counter$a <- counter$a + as.numeric(temp_number)
        }
        else if (temp_number == 2) {
          counter$b <- counter$b + as.numeric(temp_number)
        }
        else if (temp_number == 3) {
          counter$c <- counter$c + as.numeric(temp_number)
        }
        else if (temp_number == 4) {
          counter$d <- counter$d + as.numeric(temp_number)
        }
      }
    }


    # Generates total risk level pts and assigns it to count()
    count <- reactiveVal(0)
    for (val in reactiveValuesToList(counter)) {
      count(count() + val)
    }


    # Information Update Based on Risk Level ----------------------------------
    risk <<- reactiveVal()

    #  Very High Risk
    if (counter$d > 0) {
      output$risk_level <- very_high_risk_info

      # value box
      output$recommendations <- very_high_risk_recommendations
      risk("very_high")
    }
    # High Risk
    else if (counter$c > 0 | (count() > 4)) {
      output$risk_level <- high_risk_info

      # value box
      output$recommendations <- high_risk_recommendations
      risk("high")

    }
    # Moderate Risk
    else if (count () > 2 && count() < 5) {
      output$risk_level <- moderate_risk_info

      # value box
      output$recommendations <- moderate_risk_recommendations
      risk("moderate")
    }

    # Low risk
    else {
      output$risk_level <- low_risk_info

      # value box
      output$recommendations <- low_risk_recommendations
      risk("low")
    }
    surveillanceBuild(risk())
    updateSurveillanceTable(surveillance_recommendations)

    # TABLE 2 - Toxicities ----------------------------------------------------
    # create dataframe for toxicities for all classes except anthracyclines and her2
    if (risk_list[["a"]] != "Anthracycline" &&
        risk_list[["a"]] != "HER-2 targeted therapies") {
      output$surveillance <-
        renderText(NULL)
      cadiac_toxicity <<- cardiac_toxicity_data %>%
        # filter_all(cardiac_toxicity_data, any_vars(! is.na(.))) %>%
        mutate(
          picture = paste0(
            "<img src=\"",
            image,
            "\" height=\"40\" data-toggle=\"tooltip\" data-placement=\"right\" title=\"",
            input$drug_name,
            "\"></img>"
            ,
            "<figcaption>",
            toxicity,
            "</figcaption>"
          )
        ) %>%
        select(picture, input$drug_name) %>%
        filter(!is.na(cardiac_toxicity_data[input$drug_name])) %>%
        unique()

      # print(cardiac_toxicity)
      output$tox_table <- DT::renderDataTable(
        cadiac_toxicity,
        options = list(
          dom = "t",
          ordering = FALSE,
          columnDefs = list(list(
            className = 'dt-nowrap dt-center', targets = 0
          )),
          paging = FALSE,
          searching = FALSE,
          scroller = FALSE,
          headerCallback = JS(headerCallbackRemoveHeaderFooter),
          autoWidth = FALSE
        ),
        selection = 'none',
        callback = JS(
          "$('table.dataTable.no-footer').css('border-bottom', 'none');",
          "$('table.dataTable.no-footer').css( 'word-break', 'break-word');"
        ),
        class = 'row-border',
        escape = FALSE,
        rownames = FALSE,
        filter = "none",
        width = 100
      )
    }
    else {
      output$surveillance <-
        renderText(i18n$t("Data not available for this drug class."))
      output$tox_table <- DT::renderDataTable(NULL)
    }

  })


  headerCallbackRemoveHeaderFooter <- c(
    "function(thead, data, start, end, display){",
    "  $('th', thead).css('display', 'none');",
    "}"
  )

  # Surveillance Stratification ---------------------------------------------
  surveillanceBuild <- function(inputRisk) {
    if (risk_list[["a"]] != "BRC-ABL inhibitors") {
      surveillance_recommendations <<- surveillance_data %>%
        filter(drug_class == risk_list[["a"]] &
                 risk == inputRisk) %>%
        mutate(
          picture = paste0(
            "<a href='https://academic.oup.com/eurheartj/article/43/41/4229/6673995?login=false#413817925' target=\"_blank\">",
            "<a href='https://academic.oup.com/view-large/figure/413817929/ehac244f12.tif' target=\"_blank\">"
            ,
            "<img src=\"",
            image,
            "\" height=\"40\" data-toggle=\"tooltip\" data-placement=\"right\" title=\"",
            study,
            "\"></img>",
            "<figcaption>",
            study,
            "</figcaption>"
          )
        ) %>%
        select(picture, text)
    }
    else {
      if ((input$drug_name == "dasatinib" ||
           input$drug_name == "ponatinib") &&
          (risk() == "high" || risk() == "very_high")) {
        surveillance_recommendations <<- surveillance_data %>%
          filter(drug_name == input$drug_name &
                   risk == risk()) %>%
          mutate(
            picture = paste0(
              "<a href='https://academic.oup.com/eurheartj/article/43/41/4229/6673995?login=false#413817925' target=\"_blank\">",
              "<a href='https://academic.oup.com/view-large/figure/413817929/ehac244f12.tif' target=\"_blank\">"
              ,
              "<img src=\"",
              image,
              "\" height=\"40\" data-toggle=\"tooltip\" data-placement=\"right\" title=\"",
              study,
              "\"></img>",
              "<figcaption>",
              study,
              "</figcaption>"
            )
          ) %>%
          select(picture, text) %>%
          unique()
      }
      else if ((input$drug_name == "dasatinib" ||
                input$drug_name == "ponatinib") &&
               (risk() == "not_app")) {
        surveillance_recommendations <<- surveillance_data %>%
          filter(drug_name == input$drug_name &
                   risk == "not_app") %>%
          mutate(
            picture = paste0(
              "<a href='https://academic.oup.com/eurheartj/article/43/41/4229/6673995?login=false#413817925' target=\"_blank\">",
              "<a href='https://academic.oup.com/view-large/figure/413817929/ehac244f12.tif' target=\"_blank\">"
              ,
              "<img src=\"",
              image,
              "\" height=\"40\" data-toggle=\"tooltip\" data-placement=\"right\" title=\"",
              study,
              "\"></img>",
              "<figcaption>",
              study,
              "</figcaption>"
            )
          ) %>%
          select(picture, text) %>%
          unique()
      }
      else if (input$drug_name == "bosutinib" ||
               input$drug_name == "nilotinib") {
        surveillance_recommendations <<- surveillance_data %>%
          filter(drug_name == input$drug_name) %>%
          mutate(
            picture = paste0(
              "<a href='https://academic.oup.com/eurheartj/article/43/41/4229/6673995?login=false#413817925' target=\"_blank\">",
              "<a href='https://academic.oup.com/view-large/figure/413817929/ehac244f12.tif' target=\"_blank\">"
              ,
              "<img src=\"",
              image,
              "\" height=\"40\" data-toggle=\"tooltip\" data-placement=\"right\" title=\"",
              study,
              "\"></img>",
              "<figcaption>",
              study,
              "</figcaption>"
            )
          ) %>%
          select(picture, text) %>%
          unique()
      }
    }
    # Should make copy of table - unclear if this is working !!!
    proxy <- dataTableProxy("surveillance_table")
    replaceData(proxy, surveillance_recommendations)

    print(typeof(surveillance_recommendations))

  }

  # Surveillance Table ------------------------------------------------------\
  updateSurveillanceTable <- function(inputSurveillanceRec) {
    output$surveillance_table <- DT::renderDT(
      isolate(surveillance_recommendations),
      options = list(
        dom = "t",
        ordering = FALSE,
        columnDefs = list(list(
          className = 'dt-nowrap dt-center', targets = 0
        )),
        paging = FALSE,
        searching = FALSE,
        scroller = FALSE,
        language = list(zeroRecords = i18n$t("No recommendations dicussed in ESC guidelines")),
        headerCallback = JS(headerCallbackRemoveHeaderFooter),
        autoWidth = FALSE,
        processing = FALSE
      ),
      selection = 'none',
      callback = JS(
        "$('table.dataTable.no-footer').css('border-bottom', 'none');",
        "$('table.dataTable.no-footer').css( 'word-break', 'break-word');"
      ),
      class = 'row-border',
      escape = FALSE,
      rownames = FALSE,
      filter = "none",
      width = 500
    )
  }



}