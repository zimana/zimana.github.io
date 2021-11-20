#Trial for Clustering Posts
#Wednesday Sept 20th - October 2nd
#Good as of Wed April 18 2018
#First, load the libraries
#load ggplot for graphics
library(ggplot2)
#load psych to use the describe function (stats). It's not necessary
#for K-means but can offer stats not normally available in R.
library(psych)
#cluster and factoextra are a must
library(cluster)
library(factoextra)
#start with importing data and viewing for anomallies
data("mtcars")
head(mtcars)
tail(mtcars)
describe(mtcars)
mtcars
mtcars.features = mtcars
mtcars.features
#the following removes classIDs. This means a column is removed for analysis.
mtcars.features$wt <- NULL
mtcars.features$qsec <- NULL
mtcars.features$vs <- NULL
mtcars.features$am <- NULL
mtcars.features$gear <- NULL
#now run to see the data
mtcars.features
#use a set.seed function. It will ensure consistent results with kmeans
set.seed(1)
#now calculate the kmeans. Select an estimate value for k. In this case 3
kmeans(mtcars.features,3)
results <- kmeans(mtcars.features,3)
print(results)
#table is used to identify where observations overlap
table(mtcars.features$hp,results$cluster)
#following plot displays cluster by color, needs circles around
ggplot(mtcars.features, aes(x = hp, y = mpg, color = results$cluster)) + geom_point() + scale_colour_gradientn(colours = rainbow(3))
#now lets plot according to K-means and SSE for optimum cluster
# First, scale the data into matrix
mtcarsmatrix <- scale(mtcars.features)
# You can check the first few rows, using n=6. Choose any number
head(mtcarsmatrix, n = 6)
# Now use the fviz function to create the graph, with vline to show the x-intercept,
# your choice for K-means.
fviz_nbclust(mtcarsmatrix, kmeans, method = "wss") + geom_vline(xintercept = 5, linetype = 2)
# Now go back and run with the selected cluster to get the cluster plot
set.seed(1)
kmeans(mtcars.features,5)
results2 <- kmeans(mtcars.features,5)
print(results2)
table(mtcars.features$hp,results2$cluster)
table(mtcars.features$mpg,results2$cluster)
#used for centers
df$cluster = factor(results2$cluster)
rcenters = as.data.frame(results2$centers)
#following plot displays cluster by color,circles around
ggplot(mtcars.features, aes(x = hp, y = mpg, color = results2$cluster)) +
  geom_point() + scale_colour_gradientn(colours=rainbow(5))
