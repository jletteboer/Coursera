complete <- function(directory, id = 1:332) {
  x <- vector()
  for (i in 1:length(id)) {
    file <- paste(directory, "/", formatC(id[i],width=3,format="d",flag="0"), 
                  ".csv", sep = "")
    data <- read.csv(file)
    x[i] <- sum(complete.cases(data))
  }
  complete <- data.frame(cbind(id,nobs=x))
  complete
}