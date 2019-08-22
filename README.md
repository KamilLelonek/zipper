# zipper

[![Build Status](https://travis-ci.org/KamilLelonek/zipper.svg?branch=master)](https://travis-ci.org/KamilLelonek/zipper)

A simple http microservice that loads a `JSON` data structure (like the
one found below) and responds with a `.zip` file whose contents are each of
the source `url` named as `filename` within the final `.zip` archive.

The service exposes a URL and responds with data as soon as possible
rather than make the user wait for the entire ZIP to be created first.

## Example data

```json
[
  {
    "url": "https://media.giphy.com/media/3oz8xD0xvAJ5FCk7Di/giphy.gif",
    "filename": "pic001.gif"
  },
  {
    "url": "https://media.giphy.com/media/l3vRfhFD8hJCiP0uQ/giphy.gif",
    "filename": "pic002.gif"
  },
  {
    "url": "https://media.giphy.com/media/3oz8xG0CiDpXqYXCz6/giphy.gif",
    "filename": "pic003.gif"
  },
  {
    "url": "https://media.giphy.com/media/3oz8xG0aignBvOhIMU/giphy.gif",
    "filename": "pic004.gif"
  },
  {
    "url": "https://media.giphy.com/media/3oz8xwooUvMqNB1zEs/giphy.gif",
    "filename": "pic005.gif"
  },
  {
    "url": "https://media.giphy.com/media/3oz8xyB3C126ZDDAuk/giphy.gif",
    "filename": "pic006.gif"
  },
  {
    "url": "https://media.giphy.com/media/3oz8xSwPT41eZOvS2A/giphy.gif",
    "filename": "pic007.gif"
  },
  {
    "url": "https://media.giphy.com/media/3oz8xAsuv5apu2cVws/giphy.gif",
    "filename": "pic008.gif"
  },
  {
    "url": "https://media.giphy.com/media/l3vR7ACppQS71ngUU/giphy.gif",
    "filename": "pic009.gif"
  },
  {
    "url": "https://media.giphy.com/media/3oz8xSD5WkRNG1R6x2/giphy.gif",
    "filename": "pic010.gif"
  },
  {
    "url": "https://media.giphy.com/media/3oz8xzYXuCWF1IXv68/giphy.gif",
    "filename": "pic011.gif"
  },
  {
    "url": "https://media.giphy.com/media/l3vRfjcp7VMSZwbGo/giphy.gif",
    "filename": "pic012.gif"
  }
]
```

## Installation

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.
