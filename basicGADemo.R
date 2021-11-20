# Load up the RGA package. This is the package that has the smarts to actually
# connect to and pull data from the Google Analytics API
library(RGA)

# Authorize the Google Analytics account
ga_token <- authorize(client.id = "448772036403-n2h1mcmsnrk4j6ne7scede3tl5cire5b.apps.googleusercontent.com", 
                      client.secret = "[client secret]")

# Perform a simple query and assign the results to a "data frame" called gaData.
# 'gaData' is just an arbitrary name, while get_ga is a function inside the RGA package.
gaData <- get_ga(profileId = "ga:9817856", start.date = "2016-01-01",
       end.date = "2016-11-12", metrics = c("ga:users", "ga:sessions"," ga:pageviews"), 
       dimensions = "ga:date", sort = NULL, filters = NULL,
       segment = NULL)

# Create a simple line chart.
# This is putting the "date" values from gaData as the x "values," the number of sessions
# (the "sessions" value) as the y values, and is then specifying that it should be plotted
# as a line chart (type="l"). The "ylim" forces a 0-base y-axis by specifying a "vector"
# that goes from 0 to the maximum value for sessions in the gaData data frame.
plot(gaData$date,gaData$sessions,type="l",ylim=c(0,max(gaData$sessions)))
