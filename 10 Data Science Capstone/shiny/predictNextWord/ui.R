dashboardPage(
  skin = "yellow",
  dashboardHeader(title = "nextWordPredictoR"),
  dashboardSidebar(sidebarMenu(
    menuItem("Predict Next Word", tabName = "predictor"),
    menuItem("Documentation", tabName = "documentation"),
    menuItem("Author", tabName = "home")
  )),
  dashboardBody(tabItems(
    tabItem("home",
            fluidRow(
              widgetUserBox(
                color = 'yellow',
                title = "John Letteboer",
                subtitle = "Data Analyst",
                type = NULL,
                src = "https://media.licdn.com/dms/image/C5603AQF9Pv7bK5GDsQ/profile-displayphoto-shrink_100_100/0?e=1562803200&v=beta&t=slCTASev2IaOajzNUN8RgT1STxhXJz0W0ZGYl2REwTk",
                closable = FALSE,
                collapsible = FALSE,
                width = 12,
                "Coursera Capstone Project",
                footer = tags$div(
                  HTML(
                    "Welcome to the Next Word Predictor!
                      <br><br>
                      <a href=\"https://www.linkedin.com/in/johnletteboer/\">
                      <i class=\"fa fa-linkedin-square fa-3x\" style=\"color:#f39c12\"></i>
                      </a>
                      <a href=\"https://github.com/jletteboer\">
                      <i class=\"fa fa-github-square\" style=\"font-size:42px;color:#f39c12\"></i>
                      </a>
                      <a href=\"https://twitter.com/jletteboer\">
                      <i class=\"fa fa-twitter-square\" style=\"font-size:42px;color:#f39c12\"></i>
                      </a>"
                  )
                )
              )
            )),
    tabItem(
      "documentation",
      includeMarkdown("README.md")
    ),
    tabItem(
      "predictor",
      fluidRow(
        gradientBox(
          title = "Enter Text",
          gradientColor = "yellow",
          closable = FALSE,
          collapsible = FALSE,
          width = 12,
          footer = textInput(
            "text",
            label = "",
            value = "How are",
            width = "auto"
          )
        )
      ),
      fluidRow(
        gradientBox(
          title = "Predicted words and scores",
          gradientColor = "yellow",
          closable = FALSE,
          collapsible = FALSE,
          width = 6,
          footer = verbatimTextOutput('predict')
        ),
        gradientBox(
          title = "Bar chart",
          gradientColor = "yellow",
          closable = FALSE,
          collapsible = FALSE,
          width = 6,
          footer = plotOutput("predict_plot")
        )
      )
    )
  ))
)

