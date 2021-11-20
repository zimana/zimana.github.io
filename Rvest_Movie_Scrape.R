library(rvest)
lego_movie <- read_html("https://www.imdb.com/title/tt4154756/")

lego_movie %>% 
  html_node("strong span") %>%
  html_text() %>%
  as.numeric()

lego_movie %>%
  html_nodes("#titleCast .itemprop span") %>%
  html_text()
