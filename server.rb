require 'bundler'
Bundler.require :default
include Colsole

require "sinatra/reloader"

if ENV['RACK_CACHE']
  require "rack/cache"
  use Rack::Cache
end

set :port, 3000
set :bind, '0.0.0.0'

get '/' do
  say "!txtgrn!Server hit"

  if params['control']
    if params['revalidate']
      cache_control :must_revalidate, max_age: (params['age']&.to_i || 10)
    else
      cache_control max_age: (params['age']&.to_i || 10)
    end
  end
  
  if params['modified']
    now = Time.now
    time = Time.new now.year, now.month, now.day, now.hour, params['modified'].to_i
    last_modified time
  end

  etag params['etag'] if params['etag']

  if params['expires']
    if params['revalidate']
      expires params['expires'].to_i, :must_revalidate
    else
      expires params['expires'].to_i
    end
  end

  # sleep 2 # to emphasize the fact that the server is working
  say "!txtred!Server hit HARD"

  rows = headers.map { |key, val| "<tr><th>#{key}:</th><td>#{val}<td></tr>" }.join
  style = "<style>* { font-family: monospace; padding: 4px }</style>"
  random = rand 999

  "#{style}<h1>Response Headers ##{random}</h1><table>#{rows}</table>"
end

