require 'sinatra'
require 'haml'
require 'dm-core'
require 'dm-migrations'
require 'dm-aggregates'

DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite3://#{Dir.pwd}/blog.db")

class Operation
  include DataMapper::Resource
  property :id, Serial
  property :time, Float
  property :cps, Float
  property :created_at, DateTime
end

Operation.auto_upgrade!

get '/' do
  @average_time = Operation.avg(:time)
  @averate_cps = Operation.avg(:cps)
  @last = Operation.last
  @operations = Operation.all(:order => [:id.desc])
  haml :index
end

get '/run' do
  this_run = Operation.create(one_million_times)
  this_run.created_at = Time.now
  this_run.save
  redirect '/'
end

def one_million_times
  num = 1_000_000
  start_time = Time.now
  num.times { |n| n = n + 1 }
  end_time = Time.now
  time = end_time - start_time
  cps = num/time
  {:time => time, :cps => cps}
end