require 'rubygems'
require 'dm-core'
require 'dm-validations'
require 'dm-aggregates'
require 'dm-timestamps'

require 'models/User'
require 'models/Task'


configure :development do
  DataMapper.setup(:default, {
    :adapter  => 'mysql',
    :host => 'localhost',
    :database => 'tasket_development',
    :username => 'root',
    :password => ''})
  #DataMapper.auto_migrate!
end
configure :test do
  DataMapper.setup(:default, {
    :adapter  => 'mysql',
    :host => 'localhost',
    :database => 'tasket_test',
    :username => 'root',
    :password => ''})
end
configure :production do
  DataMapper.setup(:default, {
    :adapter  => 'mysql',
    :host => 'localhost',
    :database => 'tasket_production',
    :username => 'frank',
    :password => 'mi3yl-Pr98fRo'})  
end

