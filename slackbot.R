choices <- read.csv("acceptable.csv", header=FALSE)
current <- sample(acceptable[,1], 1)

hook <- commandArgs(trailing=TRUE)[1]

library(httr)
out <- POST(hook,
     body=sprintf('{
    "text":"A periodic anime GIF.",
    "blocks":[
        {
            "type": "image",
            "title": {
                "type": "plain_text",
                "text": "Some anime to cheer you up; you deserve it."
            },
            "image_url": "%s",
            "alt_text": "Gochisousama!"
        }
    ]
}', current), encode='raw', content_type("json"))

