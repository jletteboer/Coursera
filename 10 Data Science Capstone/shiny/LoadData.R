# Load data and save to RDS
directory_us <- file.path("..", "data", "final", "en_US/")

blogs_con <- file(paste0(directory_us, "en_US.blogs.txt"), "r")
blogs <- readLines(blogs_con, encoding="UTF-8", skipNul = TRUE)
close(blogs_con)

news_con <- file(paste0(directory_us, "en_US.news.txt"), "r")
news <- readLines(news_con, encoding="UTF-8", skipNul = TRUE)
close(news_con)

twitter_con <- file(paste0(directory_us, "en_US.twitter.txt"), "r")
twitter <- readLines(twitter_con, encoding="UTF-8", skipNul = TRUE)
close(twitter_con)

load_curse_words <- function(curse_words_url) {
  connection <- url(curse_words_url)
  lines <- readLines(connection)
  close(connection)
  lines
}

curse_words <- load_curse_words(
  "https://raw.githubusercontent.com/LDNOOBW/List-of-Dirty-Naughty-Obscene-and-Otherwise-Bad-Words/master/en"
)

set.seed(1002)
data_sample <- c(sample(blogs, length(blogs) * 0.1, replace = F),
                 sample(news, length(news) * 0.1, replace = F),
                 sample(twitter, length(twitter) * 0.1, replace = F))

saveRDS(curse_words, 'data/curseWords.rds')
saveRDS(data_sample, 'data/sample_10p.rds')

rm(curse_words, load_curse_words, directory_us, blogs_con, blogs, news, news_con, twitter, twitter_con, 
   data_sample)


####

# blogs1 <- sample(blogs, length(blogs) * 0.1, replace = F)
# news1 <- sample(news, length(news) * 0.1, replace = F)
# twitter1 <- sample(twitter, length(twitter) * 0.1, replace = F)
# 
# WPL <- sapply(list(blogs1,news1,twitter1),function(x)
#   summary(stri_count_words(x))[c('Min.','Mean','Max.')])
# rownames(WPL) <- c('WPL_Min','WPL_Mean','WPL_Max')
# rawstats <- data.frame(
#   File = c("blogs","news","twitter"), 
#   t(rbind(sapply(list(blogs1,news1,twitter1),stri_stats_general),
#           TotalWords = sapply(list(blogs1,news1,twitter1),stri_stats_latex)[4,],
#           WPL))
# )
# # Show stats in table
# kable(rawstats) %>%
#   kable_styling(bootstrap_options = c("striped", "hover"))
