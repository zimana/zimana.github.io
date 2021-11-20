## Not run:
library(googleAnalyticsR)
library(ggplot2)
#psych is for the describe function
library(psych)
# Generate the oauth_token object obtained from Google Developer Console. 
ga_auth()
#enter the authorization code provided in the console after running ga_auth().
#current one : 4/YxR_XN-XHvU48nT2CZb57hkGsAUY2d5PcFkzHkcLjFE
#now begin code to request data
#filter sessions 
googtrial <- google_analytics_4(viewId = "9817856", date_range = c("2017-01-01", "2017-11-12"), metrics = "organicSearches",
                        dimensions = "source", dim_filters = NULL, met_filters = NULL,
                        filtersExpression = NULL, order = NULL, segments = NULL,
                        pivots = NULL, cohorts = NULL, max = 1000,
                        samplingLevel = c("DEFAULT", "SMALL", "LARGE"), metricFormat = NULL,
                        histogramBuckets = NULL, anti_sample = FALSE,
                        anti_sample_batches = "auto", slow_fetch = FALSE)
head(googtrial)
tail(googtrial)
#use str to look at the structure. 
#In this case, we have a data frame
str(googtrial)
