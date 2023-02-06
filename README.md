# MobileFoodService

API for discovering mobile food facilities written in Elixir using Phoenix Framework and Ecto.

## Quickstart

* Required Erlang and Elixir versions can be found in [`.tool-versions`](.tool-versions)

### To start your Phoenix server

* Install dependencies with `mix deps.get`
* View dependency tree with `mix deps.tree`
* View outdated dependencies with `mix hex.outdated`
* ~~Create and migrate your database with `mix ecto.setup`~~ N/A since Ecto is not used with a database.
* Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Run `mix phx.routes` to view all routes available.

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser to access the API.

View the [Phoenix Live Dashboard](http://localhost:4000/dashboard) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Overview

This example is used to illustrate an application written in the Elixir language in combination with other frameworks such as Phoenix and Ecto (with a databases-less schema) while not requiring extentive setup or configuration.

Ecto is used to demonstrate schema and changeset usage and validation while not requiring a database for data
retrieval. The `Repo` in this case is actually an external API, but it should show how a database could easily
be used.

## Examples

* <http://localhost:4000/api/v1/facilities>
* <http://localhost:4000/api/v1/facilities/735318>
* <http://localhost:4000/api/v1/facilities/types>
* <http://localhost:4000/api/v1/facilities/search?q=hamburgers>
* <http://localhost:4000/api/v1/facilities/search?latitude=37.76785244271805&longitude=-122.41610489253189&radius=1000>
(radius in meters)

## Learn more

* Official website: <https://www.phoenixframework.org/>
* Guides: <https://hexdocs.pm/phoenix/overview.html>
* Docs: <https://hexdocs.pm/phoenix>
* Forum: <https://elixirforum.com/c/phoenix-forum>
* Source: <https://github.com/phoenixframework/phoenix>

### TODO

* Cleanup auto-generated tests, fixtures, ecto, etc.
* Use database and/or cache (Redis, :ets)
* Make `MobileFoodService.MobileFoodFacilities.Type` more generic for other name/value pairs of data and resources like names, food items, cities, etc.
* Filter on `status: "APPROVED"` only?
* Run `mix format --check-formatted` during CI/DI/GH actions
* Run `mix credo` for code analysis
* Add `Dockerfile` and `entrypoint.sh`
* Add tests
