#Sentiment_Analysis_IHOP
#
#Thursday July 19th 2018
#
#Call libraries - twitteR (requires "ROAuth" for access
#Twitter account and "devtools").
#Corpus steps based on Chapter 10 of the book 
#R and Data Mining: Examples and Case Studies by Yanchang Zhao
#and tidytext sentiment, developed by Julia Silge and David Robinson
#
library(twitteR)
library(devtools)
library(ROAuth)
#call Twitter with OAuth via ROAuth
#obtain keys from apps.twitter.com - a Twitter account is required 
setup_twitter_oauth("SSAEGOWJ2OI5LT7tDUPjeP96v","bpyHAXEQu943fHuqHEKz1XsDhFiH8vAPG90d3ZnKi0JlVlxyLA","15826695-CWMB6YG8P1iw3lf2en7ndIgDfJEI6yJx3Q2lBZ7rV","B1aWinOjYHHwwUm4UlaWTCZAp7ihFATDo6NepWiBXrUdG")
#call a Timeline if you want to see an account and verify.
userTimeline("zimanaanalytics")
#create an object and call searchTwitter to see what is assocaited with a word. This returns a 
#list to be used for the sentiment analysis.
search <- searchTwitter("emoji", since = '2018-05-11')
summary(search)
search
#results from summary are arrays
#
#next step is to transform the object into a dataframe and 
#then create a corpus (a corpus is a text document). 
#
df <- twListToDF(search)
df
dim(df)
#the tm library, a text mining package, will add several functions we need.
#It will add the corpus function 
#tm is also used to provide a lexicon
#VectorSource assigns the source to be character vector.
library(tm)
myCorpus <- Corpus(VectorSource(df$text))
#
#next comes the content transformation to remove punctuations 
#and change characters to lowercase. The content_transformer
#creates the function that enacts the transformation.
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
#the following line is for removing stopwords
#from the corpus
myStopwords <- c(setdiff(stopwords('english'), c("r", "big")),
                 "the", "a", "to")
myCorpus <- tm_map(myCorpus, removeWords, myStopwords)
#the following line is for removing white space
myCorpus <- tm_map(myCorpus, stripWhitespace)
#
#remove punctuation
myCorpus <- tm_map(myCorpus, removePunctuation)
#remove numbers
myCorpus <- tm_map(myCorpus, removeNumbers)
#
#Create a Term Document Matrix which can be used to find frequent terms
tdm <- TermDocumentMatrix(myCorpus, control = list(wordlengths = c(1,Inf)))
tdm
#inspect frequent words
(freq.terms <- findFreqTerms(tdm, lowfreq = 0,highfreq = Inf))
#
#The following sets up a horizontal plot of the frequent terms.
#first set rows as a dataframe for ggplot
#can adjust term.freq value to simplify plot, 
#reduced result to a minimum frequency
#
term.freq <- rowSums(as.matrix(tdm))
term.freq <- subset(term.freq, term.freq >= 2)
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
#
#You can assign a lexicon using tidytext.
#First, create a tidy table from the tdm using the tidy function
tdm_tidy <- tidy(tdm)
tdm_tidy
#then you use the inner_join function (dplyr) and get_sentiment functions (tidytext)
# %>% is a pipe (dplyr). Means "and then"
#make sure term appears in the header of the column 

tdm_sentimentsbing <- tdm_tidy %>%
  inner_join(get_sentiments("bing"), by = c(term = "word"))
get_sentiments("bing") 
tdm_sentimentsbing
#
#The following sets up a bar chart in ggplot
#
tdm_sentimentsbing %>%
   count(sentiment, term, wt = count) %>%
   filter(n >= 0.25) %>%
   mutate(n = ifelse(sentiment == "negative", -n, n)) %>%
   mutate(term = reorder(term, n)) %>%
   ggplot(aes(term, n, fill = sentiment)) +
    geom_bar(stat = "identity") +
    theme(axis.title.x = element_text(angle = 90, hjust =1)) +
    ylab("Contribution to sentiment")
#
tdm_sentimentsafinn <- tdm_tidy %>%
  inner_join(get_sentiments("afinn"), by = c(term = "word"))

tdm_sentimentsafinn
get_sentiments("afinn")
#
tdm_sentimentsafinn %>%
  count(score, term, wt = count) %>%
  filter(n >= 0.0001) %>%
  mutate(n = ifelse(score <= "0", -n, n)) %>%
  mutate(term = reorder(term, n)) %>%
  ggplot(aes(term, n, fill = score)) +
  geom_bar(stat = "identity") +
  theme(axis.title.x = element_text(angle = 90, hjust = 1)) +
  ylab("Contribution to sentiment")
#There are anumber of choices you can take to find 
#associations to the Twitter search term.
#You can use the findAssocs function on a term with a stated minimum.
#The function returns correlation values between -1 and 1.
findAssocs(tdm, "ihop", 0.4)
findAssocs(tdm, "hamburgers", 0.5)
#
#optional - can check for what type of object for a variable.
class(search)
class(df) 
class(dfsort)
class(myCorpus)
class(tdm)
as.matrix(tdm)
