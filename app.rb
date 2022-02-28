require 'bundler/setup'
Bundler.require
require 'sinatra/reloader' if development?
require './models/count.rb'

before do
  if Count.all.size == 0
    Count.create(number: 0)
  end
end

get '/' do
  @counter = Count.all
  logger.info(@counter)
  erb :index
end

get '/count' do
  @counter = Count.all
  erb :index
end

post '/plus/:id' do
  count = Count.find(params[:id])
  count.number = count.number + 1
  count.save
  redirect '/count'
end

post '/minus/:id' do
  count = Count.find(params[:id])
  count.number = count.number - 1
  count.save
  redirect '/count'
end

post '/clear/:id' do
  count = Count.find(params[:id])
  count.number = 0
  count.save
  redirect '/count'
end

post '/add_counter' do
  Count.create(
    number: 0
  )
  redirect '/count'
end