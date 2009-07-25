require 'rubygems'
require 'sinatra'

set :environment, :production
set :port, 8000
disable :run, :reload



log = File.new("log/sinatra.log", "a")
STDOUT.reopen(log)
STDERR.reopen(log)

require '/home/sinatra/tasket/current/app.rb'

run Sinatra::Application