## Author: John Letteboer
## Date: Februari 16, 2018
## --------------------------------------------
##  Programming Assignment 3: Hospital Quality 
## --------------------------------------------
## Finding the best hospital in a state
## This function take two arguments: the 2-character abbreviated name of a state and an outcome name.
## The function reads the outcome-of-care-measures.csv file and returns a character vector with the 
## name of the hospital that has the best (i.e. lowest) 30-day mortality for the specified outcome in 
## that state. The hospital name is the name provided in the Hospital.Name variable. The outcomes can
## be one of "heart attack", "heart failure", or "pneumonia". Hospitals that do not have data on a 
## particular outcome should be excluded from the set of hospitals when deciding the rankings.

best <- function(state, outcome) {
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
  colnames(data) <- c("Hospital.Name", "State", "heart attack", 
                      "heart failure", "pneumonia")
  
  ## Check that state and outcome are valid
  if (state %in% data$State == FALSE) {
    stop("invalid state")
  }
  
  ## Return hospital name in that state with lowest 30-day death rate
  if (outcome == "heart attack") {
    sub <- subset(data, State == state, select = c("Hospital.Name", "State", outcome))
  } else if (outcome == "heart failure") {
    sub <- subset(data, State == state, select = c("Hospital.Name", "State", outcome))
  } else if (outcome == "pneumonia") {
    sub <- subset(data, State == state, select = c("Hospital.Name", "State", outcome))
  } else {
    stop("invalid outcome")
  }
  
  sub[,3] <- as.numeric(sub[,3])
  ret <- head(sub[ with(sub, order(sub[,3]), sub$Hospital.Name),],1)
  return(ret$Hospital.Name)
  
}