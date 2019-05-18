# References:
# LargeLanguageModelsinMachineTranslation 
#   (https://www.aclweb.org/anthology/D07-1090.pdf)
# JHU DS Capstone Swiftkey Dataset
#   (https://d396qusza40orc.cloudfront.net/dsscapstone/dataset/Coursera-SwiftKey.zip)
# List of Dirty, Naughty, Obscene, and Otherwise Bad Words
#   (https://github.com/LDNOOBW/List-of-Dirty-Naughty-Obscene-and-Otherwise-Bad-Words)
# Language Modeling
#   (https://web.stanford.edu/class/cs124/lec/languagemodeling.pdf)

# Predict Next Word
library(tm)
library(SnowballC)
library(dplyr)
library(stringr) # str_match, str_trim, word
library(ggplot2)

curse_words <- readRDS("data/curseWords.rds")
ngram_2 <- readRDS('data/10p_n2_gram_sparse.rds')
ngram_3 <- readRDS('data/10p_n3_gram_sparse.rds')
ngram_4 <- readRDS('data/10p_n4_gram_sparse.rds')
ngram_5 <- readRDS('data/10p_n5_gram_sparse.rds')

cleanData <- function(corpus) {
  docs <- VCorpus(VectorSource(corpus))
  docs <- tm_map(docs, function(x) iconv(x, to='UTF-8', sub='byte'))
  docs <- tm_map(docs, function(x) gsub("(f|ht)tp(s?)://(.*)[.][a-z]+", "", x))
  docs <- tm_map(docs, function(x) gsub("[^0-9A-Za-z///' ]", "", x))
  docs <- tm_map(docs, tolower)
  docs <- tm_map(docs, removePunctuation)
  docs <- tm_map(docs, removeNumbers)
  #docs <- tm_map(docs, stemDocument)
  docs <- tm_map(docs, stripWhitespace)
  docs <- tm_map(docs, PlainTextDocument)
  # Create dataframe and return
  docs <- data.frame(text=unlist(sapply(docs, `[`, "content")),
                     stringsAsFactors=F)[1,1]
  docs
}

predict <- function(input) {
  score <- data.frame(word = character(), score = numeric())
  input <- str_trim(input)
  input <- cleanData(input)
  l <- length(unlist(strsplit(input, "\\s")))
  
  if (l >= 4) {
    # Get last 4 words
    last_4_words <- word(input, sep = " ", start = l - 3, end = l)
    n5gram_match <- ngram_5 %>% filter(given_word == last_4_words) %>% mutate(ngram=5) 
    n4gram_match <- ngram_4 %>% filter(term == last_4_words) %>% mutate(ngram=4)
    n4gram_matched_count <- sum(n4gram_match$freq)
    
    if (nrow(n5gram_match) > 0) {
      score <- as.data.frame(cbind(word = n5gram_match$next_word, 
                                   score = n5gram_match$freq, 
                                   ngram = n5gram_match$ngram))
      score[,2] <- as.numeric(levels(score[,2]))[score[,2]]
      score[,2] <- score[,2]/n4gram_matched_count
      
    } else { 
      score <- data.frame(word = character(), score = numeric())
    }
  }
  if (l >= 3) {
    last_3_words <- word(input, sep = " ", start = l - 2, end = l)
    n4gram_match <- ngram_4 %>% filter(given_word == last_3_words) %>% mutate(ngram=4)
    n3gram_match <- ngram_3 %>% filter(term == last_3_words) %>% mutate(ngram=3)
    
    n3gram_matched_count <- sum(n3gram_match$freq)
    
    if (nrow(n4gram_match) > 0) {
      
      score3 <- as.data.frame(cbind(word = n4gram_match$next_word, 
                                   score = n4gram_match$freq, 
                                   ngram = n4gram_match$ngram))
      score3[,2] <- as.numeric(levels(score3[,2]))[score3[,2]]
      score3[,2] <- score3[,2]/n3gram_matched_count
      
      score <- rbind(score, score3)
    } else { 
      score <- score
    }
  }
  if (l >= 2) {
    last_2_words <- word(input, sep = " ", start = l - 1, end = l)
    n3gram_match <- ngram_3 %>% filter(given_word == last_2_words) %>% mutate(ngram=3)
    n2gram_match <- ngram_2 %>% filter(term == last_2_words) %>% mutate(ngram=2)
    n2gram_matched_count <- sum(n2gram_match$freq)
    
    if (nrow(n3gram_match) > 0) {
      score2 <- as.data.frame(cbind(word = n3gram_match$next_word, 
                                    score = n3gram_match$freq, 
                                    ngram = n3gram_match$ngram))
      score2[,2] <- as.numeric(levels(score2[,2]))[score2[,2]]
      score2[,2] <- score2[,2]/n2gram_matched_count
      
      score <- rbind(score, score2)
    } else { 
      score <- score
    }
  }
  if (l >= 1) {
    last_1_words <- word(input, sep = " ", start = l, end = l)
    n2gram_match <- ngram_2 %>% filter(given_word == last_1_words) %>% mutate(ngram=2)
    n2gram_matched_count <- sum(n2gram_match$freq)
    
    if (nrow(n2gram_match) > 0) {
      score1 <- as.data.frame(cbind(word = n2gram_match$next_word, 
                                    score = n2gram_match$freq, 
                                    ngram = n2gram_match$ngram))
      score1[,2] <- as.numeric(levels(score1[,2]))[score1[,2]]
      score1[,2] <- score1[,2]/n2gram_matched_count
      
      score <- rbind(score, score1)
    } else { 
      score <- score
    }
  }
  # remove duplicates words and Inf
  score <- score %>% filter(!is.infinite(score)) %>% filter(! duplicated(word))
  score$ngram <- as.numeric(levels(score$ngram))[score$ngram]
  
  # Calculate score for Stupid Backoff with lambda of 0.4
  if (nrow(score) > 0) {
    candidate <- max(score$ngram)
    if (candidate == 5) {
      score <- score %>% mutate(score = if_else(ngram == 4, 0.4 * score, score))
      score <- score %>% mutate(score = if_else(ngram == 3, 0.4 * 0.4 * score, score))
      score <- score %>% mutate(score = if_else(ngram == 2, 0.4 * 0.4 * 0.4 * score, score))
    } else if (candidate == 4) {
      score <- score %>% mutate(score = if_else(ngram == 3, 0.4 * score, score))
      score <- score %>% mutate(score = if_else(ngram == 2, 0.4 * 0.4 * score, score))
    } else if (candidate == 3) {
      score <- score %>% mutate(score = if_else(ngram == 2, 0.4 * score, score))
    }
  } else {
    candidate <- ""
  }
  
  top <- score %>% select(word,score) %>% top_n(8, score)
  #top <- score %>% top_n(8, score)
  top <- format(top, digits = 3, scientific = FALSE)
  top <- top %>% arrange(desc(score))
  
  if (nrow(top) > 0) {
    return(top)
  } else {
    if (candidate == 0) {
      return("Please type something ;)")
    } else {
      cat("Sorry! I don't find this in my corpus \nI don't know what comes next :(")
    }
  }
}
