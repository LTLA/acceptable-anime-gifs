# Acceptable Anime GIFs

## Overview

Sometimes we just want to post anime GIFs at work but we don't know whether they're appropriate.
This repository solves the problem by provides a quick-and-dirty REST API for retrieving acceptable anime GIFs.
Each GIF has been manually curated with a set of sentiments and "safe for work" ratings,
allowing users to easily select an appropriate GIF for the occasion.
See the documentation for the REST API at https://ltla.github.io/acceptable-anime-gifs/ for more details.

## Contribute!

PRs are welcome!
Please follow the guidelines below:

- If a show does not already exist, enter it in `shows.json` with its [MyAnimeList](https://myanimelist.net) identifier.
  If in doubt, use the first season even if the content of the GIF is occurring in a later season or OVA.
- Try to use URLs to reasonably stable resources rather than user-defined domains.
- Run `Rscript validate.R` to check that your JSON is well-formatted.
- Ratings will be manually reviewed, but one can use the API documentation above as a guideline.

## Other

By running `slackbot.R` with an incoming webhook, we can post an anime GIF to a Slack channel of your choice.
Follow the instructions at https://api.slack.com/apps to create a new app, set up a webhook, and boom!
It's done.
Best results obtained by running `slackbot.R` on a Jenkins schedule to greet your colleagues with a GIF in the morning.
