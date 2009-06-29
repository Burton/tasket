require 'helpers/helpers'
require 'digest/sha1'
require 'dm-validations'
require 'date'

class Task
  include DataMapper::Resource
  
  property :id, Integer, :serial => true
  property :tasked_id, Integer
  property :tasked_by_id, Integer
  property :body, Text
  property :status, Integer
  property :created_at, DateTime
  property :updated_at, DateTime
  property :closed_at, DateTime
  
end