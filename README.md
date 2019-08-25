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

### Language & Libraries

First of all, make sure you have Elixir installed by covering the official [installation guide](https://elixir-lang.org/install.html) on your machine.

Once you have it, you can install and compile all dependencies by running:

    mix do deps.get, deps.compile

Finally, you are able to build the project itself like:

    mix compile

### Database

Ensure you have `PostgreSQL` available on your machine. You can use either a [local installation](https://www.postgresql.org/download/) or a [Docker distribution](https://docs.docker.com/engine/examples/postgresql_service/).

The application requires to have a user (role) `postgres` created with the same password on your `localhost` under `5432` port.

Later on, create and migrate your database with

    mix ecto.setup

### Server

To start the application Phoenix server, run:

    mix phx.server

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

## Production

To prepare you application for production, you can use [`Dockerfile`](Dockerfile) for that. It will require you have [`Docker` installed locally](https://docs.docker.com/install/).

To build a `Docker` image, execute the following command:

    docker build . -t car_pooling:latest

Once built, you are able to push it to a remote repository as:

    docker push car_pooling:latest

It assumes you are authorized and logged in to a [`Docker` registry](https://docs.docker.com/registry/).

### Platform as a Service

From the deployment options, you can choose for example:

- [Heroku](https://devcenter.heroku.com/articles/container-registry-and-runtime)
- [Gigalixir](https://gigalixir.readthedocs.io/en/latest/main.html#deploy)
- [Google Cloud Platform](https://cloud.google.com/elixir/)
- [Render](https://render.com/docs/deploy-phoenix)

Depending on your needs and complexity of your application.

## Usage

There are two available endpoints for your use:

### Upload

#### Endpoint

The url for the upload is:

    POST /archives

#### Payload

The payload should be an array - a list of objects with a `url` of a file to be downloaded and a `filename` to save this file as.

```json
[
  {
    "url": "",
    "filename": ""
  }
]
```

#### Response

The result will be a payload with `202 accepted` with `archive_name` that you will be able to download once it's created.

```json
{
  "archive_name": ""
}
```

### Download

#### Endpoint

The url for the download is:

    GET /archives/<archive_name>

With the `archive_name` parameter obtained from the download endpoint.

#### Payload

There's no need to provide any additional data nor query parameters for the request.

#### Response

The result can be the following:

1. `202 accepted` when the archive is still being prepared
1. `404 not found` when there's no archive available with the given name
1. `200 ok` with the archive to download
