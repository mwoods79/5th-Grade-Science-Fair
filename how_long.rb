require 'sinatra'
require 'haml'

get '/' do
  haml :index
end

#start_time = Time.now
#number = 1_000_000

#number.times do |n|
#  dont_matter = n + 1
#end

#end_time = Time.now

#total_time = end_time - start_time

#def calc_per_second(n,t)
#  x = n*(1/t)
#end

#puts "Time: #{total_time}"
#puts "Number per second: #{calc_per_second(number, total_time)}"

