#Loading the predcition function
source("predictor.R")

function(input, output, session) {
  
  output$predict <- renderPrint({predict(input$text)})
  
  ## Plotting
  plotting <- function(x) {
    if (is.data.frame(x)) {
      x$score <- as.numeric(x$score)
      p <- ggplot(x, aes(x=reorder(word,score), y=score))
      p <- p + geom_bar(stat="identity", fill = "orange")
      p <- p + coord_flip()
      p <- p + theme_classic(base_size = 15) + labs(x = "Next Word", y = "Score")
      return(p)
    } else {
      # Empty plot, not errors ;)
      ggplot() + theme_void()
    }
    
  }
  
  output$predict_plot <- renderPlot({plotting(predict(input$text))})

}


