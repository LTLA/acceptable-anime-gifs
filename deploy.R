# This deploys the reference JSON into a series of files to mimic a REST API,
# inspired by https://dev.to/matmooredev/can-you-host-a-read-only-api-on-github-pages-1jib.

library(jsonlite)
ref <- fromJSON("reference.json", simplifyVector=FALSE)
host <- "."

# Deploying the /entry endpoint.
entry.path <- file.path(host, "entry")
unlink(entry.path, recursive=TRUE)
dir.create(entry.path, showWarnings=FALSE)

for (i in seq_along(ref)) {
    target <- file.path(entry.path, i)
    dir.create(target, showWarnings=FALSE)

    current <- ref[[i]]
    current$sentiment <- I(current$sentiment)
    out <- toJSON(current, auto_unbox=TRUE, pretty=TRUE)
    write(out, file.path(target, "index.json"))
}

# Deploying the /sentiment endpoint.
sent <- lapply(ref, function(x) unlist(x$sentiment))
entries <- rep(seq_along(ref), lengths(sent))
entry.by.sent <- split(entries, unlist(sent))

sent.path <- file.path(host, "sentiment")
unlink(sent.path, recursive=TRUE)
dir.create(sent.path, showWarnings=FALSE)
for (s in names(entry.by.sent)) {
    target <- file.path(sent.path, s)
    dir.create(target, showWarnings=FALSE)
    write(toJSON(entry.by.sent[[s]], pretty=TRUE), file.path(target, "index.json"))
}

# Deploying the /show endpoint.
show <- vapply(ref, function(x) unlist(x$show_id), 0L)
entry.by.show <- split(seq_along(show), show)

show.path <- file.path(host, "show")
unlink(show.path, recursive=TRUE)
dir.create(show.path, showWarnings=FALSE)
for (s in names(entry.by.show)) {
    target <- file.path(show.path, s)
    dir.create(target, showWarnings=FALSE)
    write(toJSON(entry.by.show[[s]], pretty=TRUE), file.path(target, "index.json"))
}

# Deploying the /rating endpoint.
rating <- vapply(ref, function(x) unlist(x$rating), 0L)
entry.by.rating <- split(seq_along(rating), rating)

rating.path <- file.path(host, "rating")
unlink(rating.path, recursive=TRUE)
dir.create(rating.path, showWarnings=FALSE)
for (s in names(entry.by.rating)) {
    target <- file.path(rating.path, s)
    dir.create(target, showWarnings=FALSE)
    write(toJSON(entry.by.rating[[s]], pretty=TRUE), file.path(target, "index.json"))
}
