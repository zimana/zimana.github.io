#call libraries for searchconsoleR. requires "googleAuthR" for access
#google search console.
library(googleAuthR)
library(searchConsoleR)
## Authorize script with Google Developer Console.  
## Add path on your laptop to your Google Developer Console Service Account secret.json file
service_token <- gar_auth_service("C:/Users/pierredebois/My_Project_ec5586432c4c.json")

## data in search console is reliable for 3 days ago so set start date = today - 3
## this is a single day pull so set end = start
start <- Sys.Date() - 3
end <- start

## set website to your URL including http://
website <- "http://www.zimana.com"

## what to download, choose between data, query, page, device, country
download_dimensions <- c('date','query','device')

## what type of Google search, choose between 'web', 'video' or 'image'
type <- c('web')

## Specify Output filepath
filepath <-"C:/Users/pierredebois/rdata"

## filename will be set like searchconsoledata_2016-02-08 (.csv will be added in next step)
filename <- paste("searchconsoledata", start, sep = "_")

## the is the full filepath + filename with .csv
output <- paste(filepath, filename, ".csv", sep = "")

## this writes the sorted search query report to full filepath and filename row.names=FALSE does not write dataframe row numbers
write.csv(searchquery, output, row.names = FALSE)

## Complete 

