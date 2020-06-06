# REST API documentation

All endpoints use `GET` and return JSON-formatted bodies.

```
GET /entry/{id}
```

Returns a dictionary containing information about a particular GIF, including:

- `show_id`, an integer identifier for the show in which the GIF occured.
- `description`, a string containing a plain-English description of the GIF contents.
- `sentiment`, a string array describing the sentiment behind the GIF.
- `url`, a string containing the URL to the GIF.
- `rating`, an integer specifying how safe for work the GIF is.

```
GET /entry
```

Returns an integer containing the total number of GIF entries.
GIF identifiers are guaranteed to be consecutive integers from 1 to this number.

```
GET /show/{show_id}
```

Returns an integer array containing the identifiers for all GIFs in a particular show.

```
GET /show
```

Returns an integer array containing all available show identifiers.

```
GET /sentiment/{sentiment}
```

Returns an integer array containing the identifiers for all GIFs tagged with a particular sentiment.

```
GET /sentiment
```

Returns a string array containing all available sentiments.

```
GET /rating/{rating}
```

Returns an integer array containing the identifiers for all GIFs with a particular rating.

- 0: safe to show your kids
- 1: safe to show your parents
- 2: safe to show your friends
- 3: safe to show your spouse
- 4: not safe to show
