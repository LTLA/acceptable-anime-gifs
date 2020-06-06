hook <- commandArgs(trailing=TRUE)[1]

# Choosing a safe for work GIF.
library(httr)
host <- "https://ltla.github.io/acceptable-anime-gifs/"
choices <- c(content(GET(file.path(host, "rating/0"))), content(GET(file.path(host, "rating/1")))
chosen <- sample(unlist(choices), 1)
info <- GET(file.path(host, "entry", chosen))
info <- content(info)

# Posting it to the designated hook.
out <- POST(hook,
     body=sprintf('{
  "text":"An anime GIF.",
  "blocks":[
    {
        "type": "image",
        "title": {
            "type": "plain_text",
            "text": "https://myanimelist.net/anime/%s"
        },
        "image_url": "%s",
        "alt_text": "%s"
    }
  ]
}', info$show_id, info$url, info$description), encode='raw', content_type("json"))

