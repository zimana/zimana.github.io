#Sentiment_Analysis_IHOP
#
#Sunday July 8th 2018
#
#call libraries for twitteR. requires "ROAuth" for access
#Twitter account and "devtools".
#Processes based on the book R and Data Mining: Examples and Case Studies by Yanchang Zhao
#and tidytext sentiment techniques by Julia Silge
#
library(twitteR)
library(devtools)
library(ROAuth)
#call Twitter with OAuth via ROAuth
setup_twitter_oauth("SSAEGOWJ2OI5LT7tDUPjeP96v","bpyHAXEQu943fHuqHEKz1XsDhFiH8vAPG90d3ZnKi0JlVlxyLA","15826695-CWMB6YG8P1iw3lf2en7ndIgDfJEI6yJx3Q2lBZ7rV","B1aWinOjYHHwwUm4UlaWTCZAp7ihFATDo6NepWiBXrUdG")
#call a Timeline if you want to see an account
userTimeline("IHOP")
#create an object and call searchTwitter to see what is assocaited with a word. This is 
#what should be used for a sentiment analysis
IHOBb4 <- searchTwitter("IHOP", since = '2018-05-14', until = '2018-06-11')
IHOP
summary(IHOBb4)
#results from summary are arrays
#can type IHOB[11:15] to view example tweets just to see what is there
#
#next step is to transform the object into a dataframe and 
#then create a corpus (a corpus is a text document). 
#
dfb4 <- twListToDF(IHOBb4)
dim(df)
#add the tm library, a text mining package, to add the corpus function.
#tm is also used to provide a lexicon
#VectorSource assigns the source to be character vectors.
library(tm)
myCorpus <- Corpus(VectorSource(df$text))
#
#next comes the content transformation to remove punctuations 
#and change characters to lowercase. The content_transformer
#creates the fucntion that enacts the transformation.
#
myCorpus <- tm_map(myCorpus, content_transformer(tolower))
#remove URLs; first create an object function...
#then use the content_transformer function in tm_map
removeURL <- function(x) gsub("http[^[:space:]]*","",x)
myCorpus <- tm_map(myCorpus, removeURL)
#
#remove anything other than letters or space
#apply to myCorpus
removeNumPunct <- function(x) gsub("[^[:alpha:][:space:]]*","",x)
myCorpus <- tm_map(myCorpus, content_transformer(removeNumPunct))
#
#the following is for removing stopwords -
#from the corpus
myStopwords <- c(setdiff(stopwords('english'), c("r", "big")),
                 "the", "a", "to")
myCorpus <- tm_map(myCorpus, removeWords, myStopwords)
#remove white space
myCorpus <- tm_map(myCorpus, stripWhitespace)
myCorpusCopy <- myCorpus
myCorpusCopy
#remove punctuation
myCorpus <- tm_map(myCorpus, removePunctuation)
#remove numbers
myCorpus <- tm_map(myCorpus, removeNumbers)
#
#
#Create a Term Document Matrix which can be used to find frequent terms
tdm <- TermDocumentMatrix(myCorpus, control = list(wordlengths = c(1,Inf)))
tdm
#inspect frequent words
(freq.terms <- findFreqTerms(tdm, lowfreq = 0,highfreq = Inf))
#
#The following sets up a horizontal plot of the frequent terms.
#first set rows as a dataframe for ggplot
#
term.freq <- rowSums(as.matrix(tdm))
term.freq <- subset(term.freq, term.freq >= 0)
df <- data.frame(term = names(term.freq), freq = term.freq)
#
#now to plot each term with ggplot2. Can use this to 
#identify each term visually and gain ideas for stemming
#need to deter
#
library(ggplot2)
ggplot(df, aes(x = term, y = freq)) + geom_bar(stat = "identity") + xlab("Terms") + ylab("Count") + coord_flip() + theme(axis.text = element_text(size = 7))
#
#using tidytext library, you can use the get_sentiment function
library(tidyverse)
library(tidytext)
library(dplyr)
library(tidyr)
#
df
#do a histogram in ggplot using df$freq
#can sort according to frequency
dfsort <- df[order(term.freq),]
dfsort
#
class(df) 
class(dfsort)
class(myCorpus)
class(myCorpusCopy)
class(tdm)
inspect(tdm)
as.matrix(tdm)
#find associations to the term ihob with at least
#a correlation (-1 to 1) using findAssocs function.
findAssocs(tdm, "ihop", 0.4)
findAssocs(tdm, "hamburgers", 0.5)
#create a tidy table from the tdm using the tidy function
tdm_tidy <- tidy(tdm)
tdm_tidy
tdm_sentiments <- tdm_tidy %>%
  inner_join(get_sentiments("bing"), by = c(term = "word"))
tdm_sentiments
tdm
df
