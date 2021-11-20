#Good as of Wednesday April 18th 2018
#call libraries for twitteR. requires "ROAuth" for access
#Twitter account and "devtools".
library(twitteR)
library(devtools)
library(ROAuth)
#call Twitter with OAuth via ROAuth
setup_twitter_oauth("SSAEGOWJ2OI5LT7tDUPjeP96v","bpyHAXEQu943fHuqHEKz1XsDhFiH8vAPG90d3ZnKi0JlVlxyLA","15826695-CWMB6YG8P1iw3lf2en7ndIgDfJEI6yJx3Q2lBZ7rV","B1aWinOjYHHwwUm4UlaWTCZAp7ihFATDo6NepWiBXrUdG")
#call a Timeline
userTimeline("smallbiztrends")
#create a variable for searching Twitter for a 
#searchterm. In this case I am using hashtags
#I've used on the Zimana account.
analytics_tweets = searchTwitter("#analytics", n = 250)
marketing_tweets = searchTwitter("#marketing", n = 250)
#print results as a check.
print(analytics_tweets)
print(marketing_tweets)
#create a dataframe from search.
dfat = twListToDF(analytics_tweets)
print(dfat)
dfmt = twListToDF(marketing_tweets)
print(dfmt)
#summary to view 
summary(dfat)
summary(dfmt)

