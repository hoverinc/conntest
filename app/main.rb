require 'sinatra'
require_relative 'http_conn'
require_relative 'redis_conn'

c = HTTPConnections.new
c.fetch

r = RedisConnections.new
r.fetch

get '/readyz' do
    'ok'
end

get '/livez' do
    'ok'
end

get '/' do
    return c.status, r.status
end