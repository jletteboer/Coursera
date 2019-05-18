library(tm)
library(RWeka)
library(slam) # rollup
library(dplyr)
library(stringr) # str_match, str_trim, word
library(data.table)
library(SnowballC)

# Functions for ngrams
n1_gram <- function(x) NGramTokenizer(x, Weka_control(min = 1, max = 1))
n2_gram <- function(x) NGramTokenizer(x, Weka_control(min = 2, max = 2))
n3_gram <- function(x) NGramTokenizer(x, Weka_control(min = 3, max = 3))
n4_gram <- function(x) NGramTokenizer(x, Weka_control(min = 4, max = 4))
n5_gram <- function(x) NGramTokenizer(x, Weka_control(min = 5, max = 5))

# Create corpus and remove/transform data  
createCorpus <- function(corpus) {
  docs <- VCorpus(VectorSource(corpus))
  docs <- tm_map(docs, function(x) iconv(x, to='UTF-8', sub='byte'))
  docs <- tm_map(docs, function(x) gsub("(f|ht)tp(s?)://(.*)[.][a-z]+", "", x))
  docs <- tm_map(docs, function(x) gsub("[^0-9A-Za-z///' ]", "", x))
  docs <- tm_map(docs, tolower)
  docs <- tm_map(docs, removePunctuation)
  docs <- tm_map(docs, removeNumbers)
  docs <- tm_map(docs, removeWords, curse_words)
  #docs <- tm_map(docs, stemDocument)
  docs <- tm_map(docs, stripWhitespace)
  # Create plain text format
  docs <- tm_map(docs, PlainTextDocument)
  docs
}

# Tokennize
tokennize <- function(x, ngrams, n, sparse, ngram_name) {
  if (sparse) {
    print("Tokennize with sparse on")
    tdm <- removeSparseTerms(TermDocumentMatrix(x, control = list(tokenize = ngrams)), n)
  } else {
    print("Tokennize with sparse off")
    tdm <- TermDocumentMatrix(x, control = list(tokenize = ngrams))
  }
  tdm <- slam::rollup(tdm, 2, na.rm=TRUE, FUN = sum)
  tdm
}

# Frequency
freq <- function(tdm) {
  print("Sorting on freq")
  freq <- sort(rowSums(as.matrix(tdm), na.rm=TRUE), decreasing=TRUE)
  data.table(word=names(freq), freq=freq)
}

# Create dataframe
dataframe <- function(x, ngram_name) {
  print("Creating a dataframe")
  df <- data.frame(term=x$word, x) 
  if (ngram_name == "n1_gram") {
    df <- df %>% rename(given_word = word) 
    df$next_word <- ""
  } else {
    df[c('given_word', 'next_word')] <- subset(str_match(df$term, "(.*) ([^ ]*)"), select=c(2,3))
  }
  df <- subset(df, select=c('term', 'given_word', 'next_word', 'freq'))
  df <- df[order(-df$freq),]
  row.names(df) <- NULL
  df
}

# Save data
save_data <- function(x, file) {
  print("Saving data")
  wr <- paste0("data/", file, ".rds")
  saveRDS(x, wr)
}

# Putting all together - Create ngram files
createNgrams <- function(corpus, ngram, n, sparse, prefix) {
  ngram_name <- as.character(substitute(ngram))
  tdm <- tokennize(x = corpus, ngrams = ngram, n = n, sparse = sparse, ngram_name = ngram_name)
  tdm_freq <- freq(tdm)
  df <- dataframe(tdm_freq, ngram_name)
  if (sparse == FALSE) {
    save_data(x = df, file = paste0(prefix,"_",ngram_name))
  } else {
    save_data(x = df, file = paste0(prefix,"_",ngram_name,"_sparse"))
  }
}