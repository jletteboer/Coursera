function(input, output, session) {
  output$max_hr <- renderValueBox({
    HRmax <- 220 - input$age
    valueBox(
      value = formatC(HRmax, digits = 1, format = "f"),
      subtitle = "Maximum Heart Rate",
      icon = icon("fas fa-heartbeat"),
      color = "yellow"
    )
  })
  output$thr_min <- renderValueBox({
    THRmin <- round((220 - input$age) * input$intensity_min/100,0)
    valueBox(
      value = formatC(THRmin, digits = 1, format = "f"),
      subtitle = "Minumum Target Heart Rate Intensity",
      icon = icon("fas fa-heartbeat"),
      color = "yellow"
    )
  })
  output$thr_max <- renderValueBox({
    THRmax <- round((220 - input$age) * input$intensity_max/100,0)
    valueBox(
      value = formatC(THRmax, digits = 1, format = "f"),
      subtitle = "Maximum Target Heart Rate Intensity",
      icon = icon("fas fa-heartbeat"),
      color = "yellow"
    )
  })
}


