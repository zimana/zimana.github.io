#
#Good as of Friday July 6th 2018
#call libraries for twitteR. requires "ROAuth" for access
#Twitter account and "devtools".
#Processes based on the book R and Data Mining: Examples and Case Studies by Yanchang Zhao
#and tidytext for lexicon techniques by Julia Silge
#
library(twitteR)
library(devtools)
library(ROAuth)
#call Twitter with OAuth via ROAuth
setup_twitter_oauth("SSAEGOWJ2OI5LT7tDUPjeP96v","bpyHAXEQu943fHuqHEKz1XsDhFiH8vAPG90d3ZnKi0JlVlxyLA","15826695-CWMB6YG8P1iw3lf2en7ndIgDfJEI6yJx3Q2lBZ7rV","B1aWinOjYHHwwUm4UlaWTCZAp7ihFATDo6NepWiBXrUdG")
#call a Timeline if you want to see an account
userTimeline("IHOb")
#create an object and call searchTwitter to see what is assocaited with a word. This is 
#what should be used for a sentiment analysis
IHOB <- searchTwitter("IHOB")
IHOB
summary(IHOB)
#results from summary are arrays
#can type IHOB[11:15] to view example tweets just to see what is there
#
#next step is to transform the object into a dataframe and 
#then create a corpus (a corpus is a text document). 
#
df <- twListToDF(IHOB)
dim(df)
#add the following
library(tidyverse)
library(tidytext)
library(glue)
library(stringr)
#
#using tidytext library, you can use the get_sentiment function
#get_sentiments(lexicon = c("afinn", "bing", "nrc", "loughran"))
q <- get_sentiments