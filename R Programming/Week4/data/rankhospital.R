rankhospital <- function(state, outcome, num = "best") {
  ## Turning off warnings
  options(warn=-1)
  
  ## Read outcome data
  df <- read.csv("outcome-of-care-measures.csv", header = TRUE, colClasses = "character")
  
  # Get only metric colums we need
  metric_cols <- grep("^Hospital.30.Day.Death..Mortality..Rates.from.",
                      names(df))
  
  # Get a subset of the complete data.frame
  data <- df[, c("Hospital.Name", "State", names(df[metric_cols]))]
  
  # Rename Colnames to shorter names
  colnames(data) <- c("Hospital", "State", "heart attack", 
                      "heart failure", "pneumonia")
  
  ## Check that state and outcome are valid
  if (state %in% data$State == FALSE) {
    stop("invalid state")
  }
  
  ## Return hospital name in that state with lowest 30-day death rate
  if (outcome == "heart attack") {
    sub <- subset(data, State == state, select = c("Hospital", "State", outcome))
  } else if (outcome == "heart failure") {
    sub <- subset(data, State == state, select = c("Hospital", "State", outcome))
  } else if (outcome == "pneumonia") {
    sub <- subset(data, State == state, select = c("Hospital", "State", outcome))
  } else {
    stop("invalid outcome")
  }
  
  ## Setting new column names
  colnames(sub) <- c("hospital", "state", "rate")
  
  ## Setting rate column as numeric
  sub[,3] <- as.numeric(sub[,3])
  
  ## Order first by Rate and second by Name
  index <- with(sub, order(rate, hospital, na.last=NA))

  # Ranking
  if (is.numeric(num)) {
    rank <- sub[index[num],1]
  } else if (num == "best") {
    rank <- sub[index[1],1]
  } else if (num == "worst") {
    rank <- tail(sub[index, 1],1)
  }
  
  ## Return hospital name in that state with the given rank
  ## 30-day death rate
  return(rank)
  
}