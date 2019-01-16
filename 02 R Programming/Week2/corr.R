corr <- function(directory, threshold = 0) {
  filenames <- list.files(path = directory)
  correlations <- numeric()
  for (i in 1:length(filenames)) {
    file <- paste(directory, "/", filenames[i], sep="")
    data <- read.csv(file)
    good <- complete.cases(data)
    data <- data[good, ]
    if (nrow(data) > threshold) {
      correlations <- c(correlations, cor(data$sulfate, data$nitrate))
      }
  }
  correlations
}