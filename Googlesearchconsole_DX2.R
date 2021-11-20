#call libraries for searchconsoleR. requires "googleAuthR" for access
#google search console.
library(searchConsoleR)
library(googleAuthR)
## Authorize script with Google Developer Console.  
## Add path on your laptop to your Google Developer Console Service Account secret.json file
list_websites()
website <- "http://www.zimana.com"
list_websites()
service_token <- gar_auth_service("c:/Users/pierredebois/My_Project_ec5586432c4c.json", scope = getOption("googleAuthR.scopes.selected"))
list_websites()
s <- search_analytics(siteURL="http://www.zimana.com", startDate = Sys.Date() - 93, endDate = Sys.Date()
                      - 3, dimensions = NULL, searchType = c("web", "video", "image"),
                      dimensionFilterExp = NULL, aggregationType = c("auto", "byPage",
                                                                     "byProperty"), rowLimit = 1000, prettyNames = TRUE,
                      walk_data = c("byBatch", "byDate", "none"))
