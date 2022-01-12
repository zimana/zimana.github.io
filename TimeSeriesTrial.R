#Trial for Time Series
#Good as of Nov 19th 2021
#This is a simple time series with random noise added
set.seed(123)
t <- seq(from = 1, to = 200, by = 1) + 10 + rnorm(100, sd = 7)
# Plot your time series
plot(t)
#
#Four arguments are associated with ts – data, start, end and frequency. 
#The data argument is the data itself (a vector or matrix). 
#The start and end arguments allow us to provide a start date and end date for the series. 
#Finally the frequency argument lets us specify the number of observations per unit of time. 

