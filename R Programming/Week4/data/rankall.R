rankall <- function(outcome, num = "best") {
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
  
  # Setting rate column as numeric
  for (i in c(3,4,5)) {
    data[,i] <- as.numeric(data[,i])
  }
  
  ## Check that state and outcome are valid
  ## Check if outcome is valid
  if (outcome == "heart attack") {
    sub <- split(data[, c("Hospital", "State", outcome)], data$State)
  } else if (outcome == "heart failure") {
    sub <- split(data[, c("Hospital", "State", outcome)], data$State)
  } else if (outcome == "pneumonia") {
    sub <- split(data[, c("Hospital", "State", outcome)], data$State)
  } else {
    stop("invalid outcome")
  }
  
  ## For each state, find the hospital of the given rank
  ranking <- function(data_of_state, num) {
    ord_data_of_state <- order(data_of_state[3], data_of_state[1], na.last=NA)
    ## Check what num is
    if (is.numeric(num)) {
      data_of_state$Hospital[ord_data_of_state[num]]
    } else if (num == "worst") {
      data_of_state$Hospital[ord_data_of_state[length(ord_data_of_state)]]
    } else if (num == "best") {
      data_of_state$Hospital[ord_data_of_state[1]]
    }         
  }
  
  ## Return a data frame with the hospital names and the (abbreviated) state name
  pre_result <- lapply(sub, ranking, num)
  data.frame(hospital = unlist(pre_result), state = names(pre_result), row.names = names(pre_result))

  
}

