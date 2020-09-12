# Sinatra Cache Sandbox

This is small Sinatra app for experimenting with different cache parameters.

## Usage

1. Clone the repository.
2. Install dependencies by running `bundle`.
3. Start the server by running `ruby server.rb`.
4. Open `localhost:3000` in your browser, optionally query options (see below).
5. Review the output by Sinatra both in the browser and stdout.

## Query String Parameters

| Parameter | Meaning | Example |
|-----------|---------|---------|
| `control` | Enable Cache-Control header. | `control=1`
| `revalidate` | Add `Must-Revalidate` | `control=10&revalidate=1`
| `expires` | Use `Expires` header. Can also be set with `revalidate` | `expires=10&revalidate=1`
| `modified` | Set `Last-Modified` header. Value is minutes of the current hour | `modified=33`
| `etag` | Set `ETag` header. Value is the etag string | `etag=123`
| `age` | Set `max-age` for `Cache-Control` | `control=1&age=10`

## Rack Cache

In order to also enable the `Rack::Cache` extension, set the `RACK_CACHE=1`
environment variable before starting the server:

```shell
$ RACK_CACHE=1 ruby server.rb
```