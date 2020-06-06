# This script validates all JSON entries in 'reference.json' and 'shows.json'
# by checking that the content is well-formatted and that the URLs do exist.

library(jsonlite)
library(RCurl)

shows <- fromJSON("shows.json", simplifyVector=FALSE)
for (current in shows) {
    stopifnot(identical(names(current), c("show_id", "show_name")))
    stopifnot(is.integer(current$show_id), length(current$show_id)==1L)
    stopifnot(is.character(current$show_name), length(current$show_name)==1L)
    stopifnot(url.exists(file.path("https://myanimelist.net/anime", current$show_id)))
}

all.ids <- vapply(shows, function(x) x$show_id, 0)
stopifnot(all(!duplicated(all.ids)))

ref <- fromJSON("reference.json", simplifyVector=FALSE)
for (current in ref) {
    stopifnot(identical(names(current), c("show_id", "description", "sentiment", "url", "rating")))
    stopifnot(is.character(current$description), length(current$description)==1L)
    stopifnot(is.list(current$sentiment), length(current$sentiment)>=1L)

    stopifnot(is.character(current$url), length(current$url)==1L)
    stopifnot(url.exists(current$url))

    stopifnot(is.integer(current$rating), length(current$rating)==1L)
    stopifnot(is.integer(current$show_id), length(current$show_id)==1L)
    stopifnot(current$show_id %in% all.ids)
}
