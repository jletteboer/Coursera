# Cleaning Data and Create NGrams
# ==============
library(doParallel)

# Getting all created functions
source('functions.R')

# Setting variables
prefix = "10p"
dir = paste0("data/sample_",prefix, ".rds")

# Setting up doParallel 
set.seed(613)
n_cores <- detectCores() - 1
registerDoParallel(cores=n_cores)

data <- readRDS(dir)
curse_words <- readRDS("data/curseWords.rds")

# Create a Corpus
docs <- createCorpus(data)
rm(data, curse_words)

# Create TermDocumentMatrix with Tokenizations, Frequencies, dataframe ans save results.
#createNgrams(corpus = docs, ngram = n1_gram, n = 0.9995, sparse = TRUE, prefix = prefix)
createNgrams(corpus = docs, ngram = n2_gram, n = 0.9999, sparse = TRUE, prefix = prefix)
createNgrams(corpus = docs, ngram = n3_gram, n = 0.9999, sparse = TRUE, prefix = prefix)
createNgrams(corpus = docs, ngram = n4_gram, n = 0.9999, sparse = TRUE, prefix = prefix)
createNgrams(corpus = docs, ngram = n5_gram, n = 0.9999, sparse = TRUE, prefix = prefix)

rm(docs)
