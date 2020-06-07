hook <- commandArgs(trailing=TRUE)[1]

# Choosing a safe for work GIF.
library(httr)
host <- "https://ltla.github.io/acceptable-anime-gifs/"
choices <- c(content(GET(file.path(host, "rating/0"))), content(GET(file.path(host, "rating/1"))))
chosen <- sample(unlist(choices), 1)
info <- GET(file.path(host, "entry", chosen))
info <- content(info)

# Posting it to the designated hook.
out <- POST(hook,
     body=sprintf('{
  "text":"Dude, where\'s my GIF?",
  "blocks":[
    {
        "type": "image",
        "title": {
            "type": "plain_text",
            "text": "%s"
        },
        "image_url": "%s",
        "alt_text": "Ooops! Look like the GIF didn\'t show up. Get your fix at https://myanimelist.net/anime/%s."
    }
  ]
}', info$description, info$url, info$show_id), encode='raw', content_type("json"))

