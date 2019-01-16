pollutantmean <- function(directory, pollutant, id = 1:332) {
  all <- c()
  for (i in 1:length(id)) {
    file <- c(paste(directory, "/",formatC(id[i],width=3,format="d",flag="0"),
                  ".csv", sep = ""))
    data <- read.csv(file)
    na <- is.na(data[[pollutant]])
    all <- c(all, data[[pollutant]][!na])
  }
  mean(all)
}