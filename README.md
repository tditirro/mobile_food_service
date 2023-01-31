# MobileFoodService

API for discovering mobile food facilities written in Elixir using Phoenix.

To start your Phoenix server:

* Install dependencies with `mix deps.get`
* View dependency tree with `mix deps.tree`
* View outdated dependencies with `mix hex.outdated`
* ~~Create and migrate your database with `mix ecto.setup`~~ N/A since Ecto is not used with a database.
* Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Run `mix phx.routes` to view all routes available.

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser to access the API.

View the [Phoenix Live Dashboard](http://localhost:4000/dashboard) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

* Official website: <https://www.phoenixframework.org/>
* Guides: <https://hexdocs.pm/phoenix/overview.html>
* Docs: <https://hexdocs.pm/phoenix>
* Forum: <https://elixirforum.com/c/phoenix-forum>
* Source: <https://github.com/phoenixframework/phoenix>

### TODO

* List types
* Aearch by location using [`Location Datatype`](https://dev.socrata.com/docs/datatypes/location.html)
* Cleanup auto-generated tests, fixtures, ecto, etc
* Add telemetry metrics, counters, duration, etc.
* Use database and/or cache (Redis, :ets)
* Make `MobileFoodService.MobileFoodFacilities.Type` more generic for other name/value pairs of data like name, food items, etc.
* Filter on `status: "APPROVED"` only?
* Run `mix format --check-formatted` during CI/DI/GH actions
* Run `mix credo` for code analysis
* Add tests!
