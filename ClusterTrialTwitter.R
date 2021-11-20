# Trial for Clustering Posts with Twitter
# Tuesday Nov 14th
# First,load libraries. twitteR requires "ROAuth" for access
# Twitter account and "devtools".
library(twitteR)
library(devtools)
library(ROAuth)
# Load ggplot library for graphics.
library(ggplot2)
# Load psych library to use the describe function (stats). 
# psych is not necessary for K-means but can offer stats not normally available in R.
library(psych)
# Load librarires for clustering. 
# The factoextra library provides fviz function to create the graph, 
library(cluster)
library(factoextra)
# Load the tm library for cleaning tweet text.
library(tm)
# To use twitteR, call Twitter with OAuth via ROAuth. 
setup_twitter_oauth("SSAEGOWJ2OI5LT7tDUPjeP96v","bpyHAXEQu943fHuqHEKz1XsDhFiH8vAPG90d3ZnKi0JlVlxyLA","15826695-CWMB6YG8P1iw3lf2en7ndIgDfJEI6yJx3Q2lBZ7rV","B1aWinOjYHHwwUm4UlaWTCZAp7ihFATDo6NepWiBXrUdG")
# Call a Twitter Timeline
userTimeline("zimanaanalytics")
# create a variable for searching Twitter for a 
# searchterm. In this case I am using hashtags
# I've used on the Zimana account. Max value for n is 3200.
analytics_tweets = searchTwitter("#analytics", n = 50)
marketing_tweets = searchTwitter("#marketing", n = 50)
# print results as a check.
print(analytics_tweets)
print(marketing_tweets)
# create a dataframe from search.  The function twListToDF summarizes
# tweets and places them in a dataframe.
dfat = twListToDF(analytics_tweets)
dfmt = twListToDF(marketing_tweets)
# print the dataframe as a sanity check.
print(dfat)
print(dfmt)
# summary, head, and tail to view 
summary(dfat)
summary(dfmt)
head(dfat)
head(dfmt)
tail(dfat)
tail(dfmt)

# The following begins the set up for cluster analysis 
# Start with importing data.

dfat
dfat.features = dfat
dfat.features
dfmt.features = dfmt
dfat.features
dfmt.features
#the following removes classIDs. This means a column is removed for analysis.
dfmt.features$longitude <- NULL
dfmt.features$latitude <- NULL
dfmt.features$statusSource <- NULL
dfmt.features$replyToSN <- NULL
dfmt.features$truncated <- NULL

dfmt.features$created <- NULL
dfmt.features$isRetweet <- NULL
dfmt.features$replyToUID <- NULL
dfmt.features$replyToSN <- NULL
dfmt.features$retweeted <- NULL
dfmt.features$replyToSID <- NULL
dfmt.features$favorited <- NULL
dfmt.features$text <- NULL

dfat.features$longitude <- NULL
dfat.features$latitude <- NULL
dfat.features$statusSource <- NULL
dfat.features$replyToSN <- NULL
dfat.features$truncated <- NULL

dfat.features$created <- NULL
dfat.features$isRetweet <- NULL
dfat.features$replyToUID <- NULL
dfat.features$replyToSN <- NULL
dfat.features$retweeted <- NULL
dfat.features$replyToSID <- NULL
dfat.features$favorited <- NULL
dfat.features$text <- NULL

#now run to see the data with the columns removed
dfmt.features
dfat.features
hist(dfmt.features$retweetCount)


# Use a set.seed function. It will ensure consistent results with kmeans
set.seed(1)
# Now calculate the kmeans. 
# Select an estimate value for k. In this case 12
kmeans(dfat.features,12)
results <- kmeans(dfat.features,12)
print(results)
results3 <- kmeans(dfmt.features,12)
print(results3)
#table is used to identify where observations overlap
table(dfat.features$retweetCount,results$cluster)
table(dfmt.features$retweetCount,results3$cluster)
#following plot displays cluster by color, needs circles around
ggplot(dfat.features, aes(x= favoriteCount, y = retweetCount, color = results$cluster)) + geom_point() + scale_colour_gradientn(colours=rainbow(10))
ggplot(dfmt.features, aes(x= favoriteCount, y = retweetCount, color = results$cluster)) + geom_point() + scale_colour_gradientn(colours=rainbow(10))
#now lets plot according to K-means and SSE for optimum cluster
# First, scale the data into matrix
dfatmatrix <- scale(dfat.features)
# You can check the first few rows, using n=6. Choose any number
head(dfatmatrix, n = 6)
# Now use the fviz function to create the graph, with vline to show the x-intercept,
# your choice for K-means.
fviz_nbclust(dfatmatrix, kmeans, method = "wss") + geom_vline(xintercept = 5, linetype = 2)
dfatmatrix
# Now go back and run with the selected cluster to get the cluster plot
set.seed(1)
kmeans(dfat.features,5)
results2 <- kmeans(dfat.features,5)
print(results2)
table(dfat.features$retweetCount,results2$cluster)
table(mtcars.features$mpg,results2$cluster)
#used for centers
df$cluster = factor(results2$cluster)
rcenters = as.data.frame(results2$centers)
#following plot displays cluster by color, needs circles around
ggplot(mtcars.features, aes(x = hp, y = mpg, color = results2$cluster)) +
  geom_point() + scale_colour_gradientn(colours=rainbow(5))
