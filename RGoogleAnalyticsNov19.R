require(RGoogleAnalytics)
# Authorize the Google Analytics account
# This need not be executed in every session once the token object is created 
# and saved
client.id <- "256280267745-ki6702eksauo7friq9q8s9ojue397kqk.apps.googleusercontent.com"
client.secret <- "2Ct9x_P3cN8mblR83-BrL2xx" 
token <- Auth(client.id, client.secret)


# Save the token object for future sessions
save(token,file="./token_file")

# In future sessions it can be loaded by running load("./token_file")

ValidateToken(token)

# Build a list of all the Query Parameters
query.list <- Init(start.date = "2017-03-15",
                   end.date = "2017-04-14",
                   dimensions = "ga:date,ga:pagePath,ga:hour,ga:medium",
                   metrics = "ga:sessions,ga:pageviews",
                   max.results = 10000,
                   sort = "ga:date",
                   table.id = "ga:33093633")

# Create the Query Builder object so that the query parameters are validated
ga.query <- QueryBuilder(query.list)

# Extract the data and store it in a data-frame
ga.data <- GetReportData(ga.query, token, split_daywise = T)
head(ga.data)
