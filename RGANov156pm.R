## Not run:
# load package
library(RGA)
# get access token
authorize(username = getOption("rga.username"),
          +           client.id = getOption("256280267745-ki6702eksauo7friq9q8s9ojue397kqk.apps.googleusercontent.com"),
          +           client.secret = getOption("2Ct9x_P3cN8mblR83-BrL2xx"),
          +           cache = getOption("rga.cache"), reauth = TRUE, token = NULL)
# get a GA profiles
ga_profiles <- list_profiles("4/1APw2wSv82vvJCUeIrUHvHQgfMnWCiHrCQJjW6rf1Ok")
# choose the profile ID by site URL
id <- ga_profiles[grep("http://www.zimana.com", ga_profiles$website.url),id]
# get date when GA tracking began
first.date <- firstdate(id)
# get GA report data
ga_data <- get_ga(id, start.date = first.date, end.date = "today",
                  metrics = "ga:users,ga:sessions",
                  dimensions = "ga:userGender,ga:userAgeBracket")
## End(Not run)
