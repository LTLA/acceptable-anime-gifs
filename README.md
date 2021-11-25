# Acceptable Anime GIFs

## Motivation

Sometimes we just want to post anime GIFs at work but we don't know whether they're appropriate.
This repository solves the problem by provides a quick-and-dirty REST API for retrieving acceptable anime GIFs.
Each GIF has been manually curated with a set of sentiments, 
allowing users to easily select an appropriate GIF for the occasion.
See the documentation for the [REST API](https://github.com/LTLA/anime-gif-api/) for more details.

## Metadata requirements

All GIFs are located in `registry/` and are organized into subdirectories by show.
The exact name of each show's subdirectory is arbitrary - we use the `<ID>_<SHORT_NAME>` convention to make it easier to work with.
Each subdirectory should have a corresponding JSON file of the same name, containing the following fields:

- `id`: the [MyAnimeList](https://myanimelist.net) identifier for the show.
- `name`: the name of the show, again according to MyAnimeList (non-ASCII characters are supported).
- `characters`: an object containing character names and their MyAnimeList IDs.

Each subdirectory contains the GIFs associated with the corresponding show.
The exact name of each GIF is arbitrary, but as a convention, we use integers padded with zeros to 4 digits.
Each GIF should be accompanied by a JSON metadata file of the same name, containing the following fields:

- `characters`: an array of strings containing the names of characters involved in the GIF.
  Each entry should be present in the `characters` in the show-level metadata.
- `sentiments`: an array of strings containing the sentiments expressed in the GIF.
- `url`: a string specifying the original source of the GIF.

## Build instructions

The show- and GIF-level metadata are validated and collected into a set of manifest files by the [validator](https://github.com/LTLA/acceptable-anime-gifs-validator).
This makes it easier to use the metadata to identify a subset of interesting GIFs without incurring the cost of cloning the whole repository.
The manifests are regenerated automatically on each push by a GitHub Action and stored as release artifacts for re-use in other projects:

```sh
# Get the manifest of available shows:
wget https://github.com/LTLA/acceptable-anime-gifs/releases/download/latest/shows.json

# Get the manifest of available GIFs:
wget https://github.com/LTLA/acceptable-anime-gifs/releases/download/latest/gifs.json
```

## Contribute!

PRs are welcome!
Please follow the guidelines below:

- If a show does not already exist, create a directory with its associated MyAnimeList metadata.
  If in doubt, use the first season even if the content of the GIF is occurring in a later season or OVA.
  Not all `characters` need to be specified at this point, only those that are involved in GIFs.
- When adding a GIF to an existing show, add new characters to the show-level metadata if necessary.
  Names and IDs should be taken from the MyAnimeList character listings for any given show, e.g., [Nichijou](https://myanimelist.net/anime/10165/Nichijou/characters).
- A GitHub Action will automatically run on any PR to check that the metadata is valid.
