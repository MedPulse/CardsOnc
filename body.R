menu_tab <- lapply(1:3, function(i) {
  tabPanel(sprintf("Menu %s", i),
           sprintf("Hello tab %s", i))
})


body = dashboardBody(
  use_theme(custom_colors_theme),
  usei18n(i18n),
  useShinyjs(),
  # Initialize shinyjs
  
  
  tags$head(
    tags$link(rel = "stylesheet", href = "https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css"),
    tags$link(rel = "stylesheet", type = "text/css", href = "style.css")
  ),
  # Custom styles for floating ToC
  # tags$head(
  #   tags$style(HTML("
  #     #floating-toc {
  #       position: fixed;
  #       top: 100px;
  #       left: 0;
  #       width: 200px;
  #       z-index: 1000;
  #       background-color: #f8f9fa;
  #       border: 1px solid #ddd;
  #       padding: 10px;
  #       height: 300px;
  #       overflow-y: auto;
  #     }
  #     #content {
  #       margin-left: 220px;
  #     }
  #   "))
  # ),
  tabItems(
    tabItem(
      tabName = "Tab1",
      fluidRow(column(width = 12,
                      
                      div(
                        id = "instructions"
                        ,
                        bs4Card(
                          width = NULL,
                          title = "Instructions",
                          collapsable = TRUE,
                          collapsed = TRUE,
                          tags$p("Here are the instructions on how to use this application:"),
                          tags$ul(
                            tags$li("Select the chemotherapy agent"),
                            tags$li(
                              "Select all the applicable risk factors, patient’s age, cardiovascular diseases, qtc length, baseline cardiac function and if the patient has had prior cancer treatments"
                            ),
                            tags$li("Then click “Submit” to see results")
                          )
                        )
                      )),),
      
      column(
        width = 12,
        bs4CardLayout(
          type = "columns",
          # Chemotherapy agent -------------------------------------------------s-----
          
          box(
            width = NULL,
            title = i18n$t("Chemotherapy Agent"),
            solidHeader = TRUE,
            status = "primary",
            closable = FALSE,
            collapsible = FALSE,
            
            # Drop down
            pickerInput(
              inputId = "drug_name",
              label = i18n$t("Chemotherapy Agent"),
              choices = chemo_agents,
              options = list(`live-search` = TRUE)
            )
          ),
          
          # Risk Factor Selection ---------------------------------------------------
          box(
            width = NULL,
            title = i18n$t("Cardiovascular Risk Factors"),
            solidHeader = TRUE,
            status = "primary",
            closable = FALSE,
            collapsible = FALSE,
            awesomeCheckboxGroup(
              inputId = "risk_factors",
              label = i18n$t("Select all that apply"),
              choices = c(
                "Significant smoking history or current smoker" = "smoke",
                "BMI ≥ 30 kg/m2" = "obese",
                "Hypertension" = "htn",
                "Hyperlipidemia" = "hld",
                "Diabetes Mellitus" = "dm",
                "Chronic kidney disease" = "ckd",
                "Proteinuria" = "urine_pt",
                "Family history of thrombophilia" = "thrombophilia",
                "None of the above" = NULL
              )
            ),
            
            awesomeRadio(
              inputId = "age",
              label = i18n$t("Select the patient's age"),
              choices = c(
                "<60" = "age_low",
                "60-64" = "age_low_mod",
                "65-74" = "age_mod",
                "75-79" = "age_mod_high",
                "≥80" = "age_high"
              ),
              selected = "age_low"
            )
          ),
          
          
          # Previous CV Disease -----------------------------------------------------
          
          box(
            width = NULL,
            title = i18n$t("Previous Cardiovascular Disease"),
            solidHeader = TRUE,
            status = "primary",
            closable = FALSE,
            collapsible = FALSE,
            awesomeCheckboxGroup(
              inputId = "cvd",
              label = i18n$t("Select all that apply"),
              choices = c(
                "Heart failure or cardiomyopathy" = "hf_cm",
                "Severe valvular heart disease" = "vhd",
                "Myocardial infarction, PCI, or CABG" = "mi_pci_cabg",
                "Stable angina" = "angina",
                "Arterial Vascular Disease" = "avd",
                "Abnormal ankle-brachial pressure index" = "abi",
                "Pulmonary hypertension" = "ph",
                "Arterial thrombosis with TKI" = "tki",
                "Venous thrombosis or pulmonary embolism" = "dvt_pe",
                "Arrhythmia" = "arrhythmia",
                "Cardiac Amyloidosis" = "amyloid",
                "Prior Proteosome Inhibitor toxicity" = "pi_tox",
                "Prior immunomodulatory cardiovascular toxicity" = "imid_tox",
                "Left ventricular hypertrophy" = "lvh"
              )
            ),
            awesomeRadio(
              inputId = "qtc",
              label = i18n$t("QTc Length"),
              choices = c(
                "QTc < 450 ms (men), 460 ms (women)" = "nl_qtc",
                "QTc ≥ 450 ms (men)" = "mid_qtc",
                "QTc ≥ 460 (women)" = "mid_qtc",
                "QTc ≥ 480 ms (men or women)" = "long_qtc"
              )
            )
          ),
          
          
          # Baseline Cardiac Function -----------------------------------------------
          
          box(
            width = NULL,
            title = i18n$t("Baseline Cardiac Function"),
            solidHeader = TRUE,
            status = "primary",
            closable = FALSE,
            collapsible = FALSE,
            awesomeCheckboxGroup(
              inputId = "bcf",
              label = i18n$t("Select all that apply"),
              choices = c(
                "Elevated cardiac troponin" = "elev_trop",
                "Elevated natriuretic peptide" = "elev_np"
              )
            ),
            awesomeRadio(
              inputId = "ef",
              label = i18n$t("Ejection Fraction"),
              choices = c(
                "> 54%" = "na",
                "50 - 54%" = "mod_ef",
                "< 50%" = "red_ef"
                
                
              )
            )
          ),
          
          
          # Current and Prior Cancer Treatments -------------------------------------
          
          box(
            width = NULL,
            title = i18n$t("Current and Prior Cancer Treatments"),
            solidHeader = TRUE,
            status = "primary",
            closable = FALSE,
            collapsible = FALSE,
            
            awesomeCheckboxGroup(
              inputId = "ctx",
              label = i18n$t("Previous cancer treatment"),
              c(
                "Dexamethasone > 160 mg/month" = "dex",
                "Anthracycline before HER2-targeted therapy" = "ant_her2"
              )
            ),
            
            awesomeCheckboxGroup(
              inputId = "exp",
              label = i18n$t("Previous exposure to"),
              c(
                "Anthracycline" = "ant",
                "Trastuzumab" = "tras",
                "Radiation to left chest or mediastinum" = "rt",
                "Non-anthracycline chemotherapy" = "non_ant"
              )
            )
          )
        )
        
        
      ),
      actionButton(
        inputId = "submit",
        status = "danger",
        size = "lg",
        label = i18n$t("Submit"),
        class = "sticky-btn"
      ),
      
      column(
        width = 12,
        bs4InfoBoxOutput(width = NULL, "risk_level"),
        bs4ValueBoxOutput(width = NULL, "recommendations"),
        div(
          id = "tab_toggle",
          bs4TabCard(
            id = "tabcard",
            selected = i18n$t("Surveillance"),
            width = NULL,
            status = "navy",
            solidHeader = FALSE,
            collapsible = FALSE,
            type = "tabs",
            
            # Tab 1 - Surveillance ----------------------------------------------------
            tabPanel(
              mainPanel
              (width = NULL,
                DT::dataTableOutput("surveillance_table")),
              title = i18n$t("Surveillance")
            ),
            
            # Tab 2 - Cardiovascular Toxicity -----------------------------------------
            tabPanel(
              title = i18n$t("Cardiovascular Toxicity"),
              textOutput("surveillance"),
              DT::dataTableOutput("tox_table"),
              width = NULL
            )
          )
        ) %>% shinyjs::hidden(),
        
        # Tabs --------------------------------------------------------------------
        div(id = "tab_toggle", ) %>% shinyjs::hidden()
        
      )
      
    ),
    
    # Tab 2 -------------------------------------------------------------------
    tabItem(
      tabName = "Tab2",
      title = textOutput(i18n$t("Medication Information")),
      column (
        width = 12,
        selectInput(
          "selected_tabBox",
          "Select a Class",
          choices = list(
            "VEGF Inhibitor" = "vegf",
            "Immune Checkpoint Inhibitors" = "ICI",
            "TKI" = "TKI",
            "HSCT" = "HSCT",
            "Anthracyclines" = "anthra",
            "HER2 Therapies" = "her2",
            "CAR-T Cells" = "cart",
            "BTKI" = "BTKi",
            "Radiation-Induced Cardiovascular Disease" = "rad",
            "Fluoropyrimidine-induced cardiotoxicity" = "fluoro",
            "Multiple Myeloma Treatments" = "mm"
          ),
          selected = "vegf"
        )
      ),
      column(
        width = 12,
        conditionalPanel(
          condition = "input.selected_tabBox == 'vegf'",
          tabBox(
            id = "tabBox1",
            width = 12,
            tabPanel(title = "Definition",
                     value = "tab1",
                     p("This is Tab 1 in TabBox 1")),
            tabPanel(title = "Mechanism of Action",
                     value = "tab2",
                     p("This is Tab 2 in TabBox 1")),
            tabPanel(title = "Types",
                     value = "tab2",
                     p("This is Tab 2 in TabBox 1")),
            tabPanel(title = "Cardiovascular Toxicity",
                     value = "tab2",
                     p("This is Tab 2 in TabBox 1")),
            tabPanel(title = "Risk Stratification",
                     value = "tab2",
                     p("This is Tab 2 in TabBox 1")),
            tabPanel(title = "Surveillance",
                     value = "tab2",
                     p("This is Tab 2 in TabBox 1")),
            tabPanel(title = "Diagnosis/Management of Cardiovascular Toxicities",
                     value = "tab2",
                     p("This is Tab 2 in TabBox 1"))
          )
        ),
        conditionalPanel(
          condition = "input.selected_tabBox == 'ICI'",
          tabBox(
            id = "tabBox1",
            width = 12,
            tabPanel(title = "Definition",
                     value = "tab1",
                     p("This is Tab 1 in TabBox 1")),
            tabPanel(title = "Mechanism of Action",
                     value = "tab2",
                     p("This is Tab 2 in TabBox 1")),
            tabPanel(title = "Types",
                     value = "tab2",
                     p("This is Tab 2 in TabBox 1")),
            tabPanel(title = "Cardiovascular Toxicity",
                     value = "tab2",
                     p("This is Tab 2 in TabBox 1")),
            tabPanel(title = "Risk Stratification",
                     value = "tab2",
                     p("This is Tab 2 in TabBox 1")),
            tabPanel(title = "Surveillance",
                     value = "tab2",
                     p("This is Tab 2 in TabBox 1")),
            tabPanel(title = "Diagnosis/Management of Cardiovascular Toxicities",
                     value = "tab2",
                     p("This is Tab 2 in TabBox 1"))
          )
        ),
        conditionalPanel(
          condition = "input.selected_tabBox == 'TKI'",
          tabBox(
            id = "tabBox1",
            width = 12,
            tabPanel(title = "Definition",
                     value = "tab1",
                     p("This is Tab 1 in TabBox 1")),
            tabPanel(title = "Mechanism of Action",
                     value = "tab2",
                     p("This is Tab 2 in TabBox 1")),
            tabPanel(title = "Types",
                     value = "tab2",
                     p("This is Tab 2 in TabBox 1")),
            tabPanel(title = "Cardiovascular Toxicity",
                     value = "tab2",
                     p("This is Tab 2 in TabBox 1")),
            tabPanel(title = "Risk Stratification",
                     value = "tab2",
                     p("This is Tab 2 in TabBox 1")),
            tabPanel(title = "Surveillance",
                     value = "tab2",
                     p("This is Tab 2 in TabBox 1")),
            tabPanel(title = "Diagnosis/Management of Cardiovascular Toxicities",
                     value = "tab2",
                     p("This is Tab 2 in TabBox 1"))
          )
        ),
        conditionalPanel(
          condition = "input.selected_tabBox == 'HSCT'",
          tabBox(
            id = "tabBox1",
            width = 12,
            tabPanel(title = "Definition",
                     value = "tab1",
                     p("This is Tab 1 in TabBox 1")),
            tabPanel(title = "Mechanism of Action",
                     value = "tab2",
                     p("This is Tab 2 in TabBox 1")),
            tabPanel(title = "Types",
                     value = "tab2",
                     p("This is Tab 2 in TabBox 1")),
            tabPanel(title = "Cardiovascular Toxicity",
                     value = "tab2",
                     p("This is Tab 2 in TabBox 1")),
            tabPanel(title = "Risk Stratification",
                     value = "tab2",
                     p("This is Tab 2 in TabBox 1")),
            tabPanel(title = "Surveillance",
                     value = "tab2",
                     p("This is Tab 2 in TabBox 1")),
            tabPanel(title = "Diagnosis/Management of Cardiovascular Toxicities",
                     value = "tab2",
                     p("This is Tab 2 in TabBox 1"))
          )
        ),
        conditionalPanel(
          condition = "input.selected_tabBox == 'anthra'",
          tabBox(
            id = "tabBox1",
            width = 12,
            tabPanel(
              title = "Definition",
              value = "tab1",
              HTML(
                "<p>Anthracyclines are a class of drugs derived from the Streptomyces bacterium used in the treatment of various types of cancers. After the first type (daunorubicin) was discovered in the early 1960s, there have been other different types also approved for treatment. Cancers that anthracyclines are used to treat include Acute lymphocytic and myelogenous leukemia, Hodgkin's and non-Hodgkin's lymphoma, breast cancer, and ovarian cancer. (<a href=\"https://www.ncbi.nlm.nih.gov/pmc/articles/PMC7093379/\">Cardinale et al, 2020</a>)</p>"
              )
            ),
            tabPanel(
              title = "Mechanism of Action",
              value = "tab2",
              HTML(
                "<p>There are several proposed mechanisms of action of the anthracycline medication which include interaction with enzyme topoisomerase-II, &nbsp;DNA intercalation, DNA adduct formation, and Reactive oxygen species generation to cause DNA damage and lipid peroxidation. All these mechanisms account for the cardiotoxic and cytostatic action of this class of medication.(<a href=\"https://www.ncbi.nlm.nih.gov/books/NBK538187/\">Venkatesh et al, 2023</a>)</p>
<p>The main mechanism of cardiotoxicity is believed to be through the inhibition of the enzyme topoisomerase II in the cardiac myocytes. This leads to activation of cell death pathways, inhibition of mitochondrial biogenesis, and deposition of ROS resulting in cardiac myocyte dysfunction. (<a href=\"https://pubmed.ncbi.nlm.nih.gov/29217634/\">Henriksen, 2018</a>)</p>"
              )
            ),
            tabPanel(
              title = "Types",
              value = "tab2",
              HTML(
                "<ul>
    <li>Daunorubicin</li>
    <li>Doxorubicin</li>
    <li>Idarubicin</li>
    <li>Epirubicin</li>
    <li>Valrubicin</li>
    <li>Mitoxantrone </li>
</ul>
<p>(<a href=\"https://www.ncbi.nlm.nih.gov/books/NBK538187/\">Venkatesh,et al.2023</a>)</p>"
              )
            ),
            tabPanel(
              title = "Cardiovascular Toxicity",
              value = "tab2",
              HTML(
                "<ul>
<li>Congestive cardiac failure</li>
<li>ANT-induced cardiomyopathy</li>
</ul>"
              )
            ),
            tabPanel(
              title = "Surveillance",
              value = "tab2",
              HTML('<p><strong>Cardiac monitoring protocol for pregnant women receiving anthracycline-based chemotherapy</strong><br /><span style="text-decoration: underline;">1st Trimester:</span><br />Baseline: Physical examination, ECG, TTE(class Ia), cTn/NP(class IIb)<br />Week 12: Physical examination, ECG, TTE (class Ia), cTn/NP(class IIb)</p>
<p><strong>Anthracycline chemotherapy:</strong><br /><span style="text-decoration: underline;">Start at Week 20:</span><br />Every 4 -8 weeks: Physical examination, ECG, TTE(class Ia), cTn/NP(class IIb)<br />Week 34: Physical examination, ECG, TTE(class Ia), cTn/NP(class IIb)</p>
<p><strong>Follow-up:</strong><br />Delivery: physical examination<br />12 months post-delivery: Physical examination, ECG, TTE(class Ia), cTn/NP(class IIb)<br />(<a href="https://doi.org/10.1093/eurheartj/ehac244">ESC, 2022</a>)</p>')
            ),
            
            tabPanel(
              title = "Risk Stratification",
              value = "tab2",
              HTML('<p><strong>Very HIgh Risk</strong></p>
<ul>
<li>Heart Failure</li>
<li>Cardiomyopathy&nbsp;</li>
<li>Cancer therapy-related cardiac dysfunction (CTRCD)</li>
</ul>
<p><strong>High Risk</strong></p>
<ul>
<li>Severe Valvular Heart Disease</li>
<li>Myocardial Infarction or PCI or CABG</li>
<li>Stable Angina</li>
<li>LVEF &lt;50%</li>
<li>Age ≧ 80 years</li>
<li>Previous exposure to Anthracyclines</li>
<li>Previous radiation to Lt chest/mediastinum</li>
</ul>
<p><strong>Moderate Risk</strong></p>
<ul>
<li>LVEF 50 - 54%</li>
<li>Age 65 - 79 years &nbsp;</li>
</ul>
<p><strong>Low risk</strong></p>
<ul>
<li>Elevated baseline cTn</li>
<li>Elevated baseline NP</li>
<li>Hypertension SBP &gt;140 mmHg , DBP&gt; 90 mmHg, or on treatment</li>
<li>Chronic Kidney Disease (eGFR , 60 mL/min/1.73 m2)</li>
<li>Diabetes Mellitus (HbA1c &gt; 7.0% or &gt;53 mmol/mol, or on treatment)</li>
<li>Non-Anthracycline chemotherapy</li>
<li>Current smoker or sig smoking history</li>
<li>Obesity (BMI &gt; 30kg/m&sup2;)</li>
</ul>
<p>&nbsp;</p>
<p style="text-align: center;"><strong>Risk categories for asymptomatic adults who are childhood and adolescent cancer survivors</strong></p>
<table style="width: 100%;">
<tbody>
<tr style="height: 13.3334px;">
<td style="width: 33.3333%; height: 13.3334px;"><strong>Very high risk</strong></td>
<td style="width: 33.3333%; height: 13.3334px;">Total Doxorubicin* &ge;400 mg/m2</td>
<td style="width: 33.3333%; height: 13.3334px;">Combination therapy RT dose &gt;15,&nbsp; &ge;100</td>
</tr>
<tr style="height: 13px;">
<td style="width: 33.3333%; height: 13px;"><strong>High risk</strong></td>
<td style="width: 33.3333%; height: 13px;">Total Doxorubicin* 250 - 399 mg/m2</td>
<td style="width: 33.3333%; height: 13px;">Combination therapy RT dose 5-15,&nbsp; &ge;100</td>
</tr>
<tr style="height: 13px;">
<td style="width: 33.3333%; height: 13px;"><strong>Moderate risk</strong></td>
<td style="width: 33.3333%; height: 13px;">Total Doxorubicin* 100 - 249 mg/m2</td>
<td style="width: 33.3333%; height: 13px;">Combination therapy&nbsp; &lt;5,&nbsp; &ge;100</td>
</tr>
<tr style="height: 13px;">
<td style="width: 33.3333%; height: 13px;"><strong>Low risk</strong></td>
<td style="width: 33.3333%; height: 13px;">Total Doxorubicin* &lt;100mg/m2&nbsp;</td>
<td style="width: 33.3333%; height: 13px;">&nbsp;</td>
</tr>
</tbody>
</table>
<p><em>* or Doxorubicin Equivalent</em></p>
<p>(<a href="https://doi.org/10.1093/eurheartj/ehac244">ESC,2022</a>)</p>\'
              )
            ),
            tabPanel(
              title = "Surveillance",
              value = "tab2",
              HTML(
                \'<p><strong>Diagnosis of anthracycline chemotherapy-related cardiac dysfunction:</strong></p>
<ul>
<li>New CV symptoms</li>
<li>New abnormalities in cardiac function on CV imaging and/or</li>
<li>New increases in cardiac biomarkers</li>
</ul>
<p><strong>Management of anthracycline chemotherapy-related cardiac dysfunction<br /></strong><span style="text-decoration: underline;">Asymptomatic CTRCD</span><br /><strong>Mild (LVEF &gt;50%)</strong></p>
<ul>
<li>Continue Anthracycline with Cardiovascular monitoring</li>
<li>If GLS decreases &gt;15% or Tn increases &rarr; ACE-I/ARB and/or BB (Class IIa)</li>
<li>If NP increase &rarr; ACE-I/ARB and/or BB (Class IIb)</li>
</ul>
<p><strong>Moderate (LVEF 40-49%) and Severe (LVEF &lt;40%)</strong></p>
<ul>
<li>Interrupt anthracycline (Class I)</li>
<li>Multidisciplinary team (Class I)</li>
<li>Start HF therapy (Class I)</li>
</ul>
<p><br /><span style="text-decoration: underline;">Symptomatic CTRCD</span><br /><strong>Mild (LVEF &gt;50%)</strong></p>
<ul>
<li>MDT approach regarding interruption vs continuation of anthracycline, Start HF therapy</li>
</ul>
<p><strong>Moderate (LVEF 40-49%)</strong></p>
<ul>
<li>Interrupt anthracycline</li>
<li>Multidisciplinary team</li>
<li>Start HF therapy</li>
</ul>
<p><strong>Very severe/Severe (LVEF &lt;40%)</strong></p>
<ul>
<li>Discontinue Anthracycline</li>
<li>Multidisciplinary team</li>
<li>Start HF therapy</li>
</ul>
<p><em>* All recommendations above are class I</em></p>
<p><strong>If there is a compelling reason to continue anthracycline chemotherapy, three other strategies exist in addition to continuing the above guideline-based HF therapy.</strong></p>
<ol>
<li>Minimizing the dose of anthracycline chemotherapy administered.</li>
<li>Liposomal anthracyclines may be considered in patients with moderate or severe symptomatic or asymptomatic CTRCDc who require further anthracycline chemotherapy to reduce the risk of further CV toxicity (Class IIb)</li>
<li>Pretreatment with Dexrazoxane may be considered in patients with moderate or severe symptomatic or asymptomatic CTRCD who require further anthracycline chemotherapy to reduce the risk of further CV toxicity. (Class IIb)</li>
</ol>
<p><strong>Primary prevention</strong><br />Neurohormonal therapies during anthracycline chemotherapy (with or without subsequent trastuzumab treatment) reduced the risk of significant LVEF decline during follow-up in several small randomized controlled trials.Renin&ndash;angiotensinn&ndash;aldosterone system blockers, beta-blockers, and mineralocorticoid receptor antagonists have a significant benefit in preventing LVEF reduction.* ACE-I or ARB and beta-blockers recommended for HFf should be considered for primary prevention in high- and very high-risk patients receiving anthracyclines(IIa)<br />Dexrazoxane and liposomal anthracyclines are currently approved in patients with high and very high CTRCD risk or who have already received high cumulative anthracyclines doses. (IIb)<br /><br />Pegylated and non-pegylated liposomal doxorubicin modify pharmacokinetics and tissue distribution without compromising antitumor efficacy. In both the adjuvant and metastatic context, liposomal doxorubicin was reported to be less cardiotoxic than conventional doxorubicin. Liposomal daunorubicin is also available for acute leukemia patients in place of daunorubicin when pre-existing LVD is present (IIa)<br /><em>*No statistical differences in the incidence of overt HF or other clinical outcomes were demonstrated - in patients on Anthracyclines. (low-risk patients).</em> (<a href="https://doi.org/10.1093/eurheartj/ehac244">ESC,2022</a>)</p>'
              )),
              tabPanel(title = "Diagnosis/Management of Cardiovascular Toxicities",
                       value = "tab2",
                       HTML('')
            )
          ),
          conditionalPanel(
            condition = "input.selected_tabBox == 'her2'",
            tabBox(
              id = "tabBox1",
              width = 12,
              tabPanel(title = "Definition",
                       value = "tab1",
                       p("This is Tab 1 in TabBox 1")),
              tabPanel(title = "Mechanism of Action",
                       value = "tab2",
                       p("This is Tab 2 in TabBox 1")),
              tabPanel(title = "Types",
                       value = "tab2",
                       p("This is Tab 2 in TabBox 1")),
              tabPanel(title = "Cardiovascular Toxicity",
                       value = "tab2",
                       p("This is Tab 2 in TabBox 1")),
              tabPanel(title = "Risk Stratification",
                       value = "tab2",
                       p("This is Tab 2 in TabBox 1")),
              tabPanel(title = "Surveillance",
                       value = "tab2",
                       p("This is Tab 2 in TabBox 1")),
              tabPanel(title = "Diagnosis/Management of Cardiovascular Toxicities",
                       value = "tab2",
                       p("This is Tab 2 in TabBox 1"))
            )
          ),
          conditionalPanel(
            condition = "input.selected_tabBox == 'cart'",
            tabBox(
              id = "tabBox1",
              width = 12,
              tabPanel(title = "Definition",
                       value = "tab1",
                       p("This is Tab 1 in TabBox 1")),
              tabPanel(title = "Mechanism of Action",
                       value = "tab2",
                       p("This is Tab 2 in TabBox 1")),
              tabPanel(title = "Types",
                       value = "tab2",
                       p("This is Tab 2 in TabBox 1")),
              tabPanel(title = "Cardiovascular Toxicity",
                       value = "tab2",
                       p("This is Tab 2 in TabBox 1")),
              tabPanel(title = "Risk Stratification",
                       value = "tab2",
                       p("This is Tab 2 in TabBox 1")),
              tabPanel(title = "Surveillance",
                       value = "tab2",
                       p("This is Tab 2 in TabBox 1")),
              tabPanel(title = "Diagnosis/Management of Cardiovascular Toxicities",
                       value = "tab2",
                       p("This is Tab 2 in TabBox 1"))
            )
          ),
          conditionalPanel(
            condition = "input.selected_tabBox == 'BTKi'",
            tabBox(
              id = "tabBox1",
              width = 12,
              tabPanel(title = "Definition",
                       value = "tab1",
                       p("This is Tab 1 in TabBox 1")),
              tabPanel(title = "Mechanism of Action",
                       value = "tab2",
                       p("This is Tab 2 in TabBox 1")),
              tabPanel(title = "Types",
                       value = "tab2",
                       p("This is Tab 2 in TabBox 1")),
              tabPanel(title = "Cardiovascular Toxicity",
                       value = "tab2",
                       p("This is Tab 2 in TabBox 1")),
              tabPanel(title = "Risk Stratification",
                       value = "tab2",
                       p("This is Tab 2 in TabBox 1")),
              tabPanel(title = "Surveillance",
                       value = "tab2",
                       p("This is Tab 2 in TabBox 1")),
              tabPanel(title = "Diagnosis/Management of Cardiovascular Toxicities",
                       value = "tab2",
                       p("This is Tab 2 in TabBox 1"))
            )
          ),
          conditionalPanel(
            condition = "input.selected_tabBox == 'rad'",
            tabBox(
              id = "tabBox1",
              width = 12,
              tabPanel(title = "Definition",
                       value = "tab1",
                       p("This is Tab 1 in TabBox 1")),
              tabPanel(title = "Mechanism of Action",
                       value = "tab2",
                       p("This is Tab 2 in TabBox 1")),
              tabPanel(title = "Types",
                       value = "tab2",
                       p("This is Tab 2 in TabBox 1")),
              tabPanel(title = "Cardiovascular Toxicity",
                       value = "tab2",
                       p("This is Tab 2 in TabBox 1")),
              tabPanel(title = "Risk Stratification",
                       value = "tab2",
                       p("This is Tab 2 in TabBox 1")),
              tabPanel(title = "Surveillance",
                       value = "tab2",
                       p("This is Tab 2 in TabBox 1")),
              tabPanel(title = "Diagnosis/Management of Cardiovascular Toxicities",
                       value = "tab2",
                       p("This is Tab 2 in TabBox 1"))
            )
          ),
          conditionalPanel(
            condition = "input.selected_tabBox == 'fluoro'",
            tabBox(
              id = "tabBox1",
              width = 12,
              tabPanel(title = "Definition",
                       value = "tab1",
                       p("This is Tab 1 in TabBox 1")),
              tabPanel(title = "Mechanism of Action",
                       value = "tab2",
                       p("This is Tab 2 in TabBox 1")),
              tabPanel(title = "Types",
                       value = "tab2",
                       p("This is Tab 2 in TabBox 1")),
              tabPanel(title = "Cardiovascular Toxicity",
                       value = "tab2",
                       p("This is Tab 2 in TabBox 1")),
              tabPanel(title = "Risk Stratification",
                       value = "tab2",
                       p("This is Tab 2 in TabBox 1")),
              tabPanel(title = "Surveillance",
                       value = "tab2",
                       p("This is Tab 2 in TabBox 1")),
              tabPanel(title = "Diagnosis/Management of Cardiovascular Toxicities",
                       value = "tab2",
                       p("This is Tab 2 in TabBox 1"))
            )
          ),
          conditionalPanel(
            condition = "input.selected_tabBox == 'mm'",
            tabBox(
              id = "tabBox1",
              width = 12,
              tabPanel(title = "Definition",
                       value = "tab1",
                       p("This is Tab 1 in TabBox 1")),
              tabPanel(title = "Mechanism of Action",
                       value = "tab2",
                       p("This is Tab 2 in TabBox 1")),
              tabPanel(title = "Types",
                       value = "tab2",
                       p("This is Tab 2 in TabBox 1")),
              tabPanel(title = "Cardiovascular Toxicity",
                       value = "tab2",
                       p("This is Tab 2 in TabBox 1")),
              tabPanel(title = "Risk Stratification",
                       value = "tab2",
                       p("This is Tab 2 in TabBox 1")),
              tabPanel(title = "Surveillance",
                       value = "tab2",
                       p("This is Tab 2 in TabBox 1")),
              tabPanel(title = "Diagnosis/Management of Cardiovascular Toxicities",
                       value = "tab2",
                       p("This is Tab 2 in TabBox 1"))
            )
          )
        ),
        
        
        
        
        # uiOutput("cards")
      )
    )
  )
  