dashboardPage(skin="yellow",
  dashboardHeader(title = "HRmax Calculator"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Home", tabName = "home"),
      menuItem("Documentation", tabName = "documentation"),
      menuItem("Dashboard", tabName = "dashboard")
    )
  ),
  dashboardBody(
    tabItems(
      tabItem("home",
              fluidRow(
                widgetUserBox(
                  color = 'yellow',
                  title = "John Letteboer",
                  subtitle = "Data Analyst",
                  type = NULL,
                  src = "https://media.licdn.com/dms/image/C5603AQF9Pv7bK5GDsQ/profile-displayphoto-shrink_200_200/0?e=1556755200&v=beta&t=BfuCBNYhK0e55CmUaWjGjm_GfHQxpgX2fEIaiX8otsQ",
                  closable = FALSE,
                  collapsible = FALSE,
                  width = 12,
                  "Coursera Developing Data Products - Assignment week 4",
                  footer = "Welcome to the Heart Rate Maximum calculator!"
                )
              )
      ),
      tabItem("documentation",
              h2("Know Your Maximum and Target Heart Rates for Exercise"),
              tags$div(
                HTML(
                  "This application calculates your maximum heart rate and the 
                  target heart rate zones for the chosen age. Your maximum heart 
                  rate is about 220 minus your age<sup>1</sup>.
                  <br><br>
                  Target heart rate during moderate intensity activities is 
                  about 50-70% of maximum heart rate, while during vigorous 
                  physical activity it’s about 70-85% of maximum.
                  <br><br>
                  <strong>Usage:</strong><br>
                  Fill in your age, minimum and maximum intensity with the sliders 
                  and see what your maximum and target heart rates are.
                  <br><br>
                  <strong>Sources:</strong><br>
                  <sup>1</sup> Target Heart Rate and Estimated Maximum Heart 
                  Rate, <a target=\"_blank\" href=\"https://www.cdc.gov/physicalactivity/basics/measuring/heartrate.htm\">
                  Centers for Disease Control website</a>
                  "
                )
              )
      ),
      tabItem("dashboard",
              fluidRow(
                gradientBox(
                  title = "Select your Age",
                  icon = "fas fa-sliders",
                  gradientColor = "yellow", 
                  closable = FALSE,
                  collapsible = FALSE,
                  width = 4,
                  footer = sliderInput(
                    "age", 
                    "Age (years)",
                    min = 0, max = 100, value = 40
                  )
                ),
                gradientBox(
                  title = "Select your minimum Intensity",
                  icon = "fas fa-sliders",
                  gradientColor = "yellow", 
                  closable = FALSE,
                  collapsible = FALSE,
                  width = 4,
                  footer = sliderInput(
                    "intensity_min", 
                    "Minimum Intensity (%)",
                    min = 0, max = 100, value = 50
                  )
                ),
                gradientBox(
                  title = "Select your maximum Intensity",
                  icon = "fas fa-sliders",
                  gradientColor = "yellow", 
                  closable = FALSE,
                  collapsible = FALSE,
                  width = 4,
                  footer = sliderInput(
                    "intensity_max", 
                    "Maximum Intensity (%)",
                    min = 0, max = 100, value = 70
                  )
                )
              ),
              fluidRow(
                valueBoxOutput("max_hr"),
                valueBoxOutput("thr_min"),
                valueBoxOutput("thr_max")
              )
              
      )
    )
  )
)

