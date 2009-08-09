require 'helpers/helpers'
require 'dm-validations'
require 'date'

class Task
  include DataMapper::Resource
  
  property :id, Integer, :serial => true
  property :tasked_id, Integer
  property :tasked_by_id, Integer
  property :body, Text
  property :status, Integer, :default => 0
  property :created_at, DateTime
  property :updated_at, DateTime
  property :closed_at, DateTime
  
  belongs_to :tasked, :class => User, :child_key => [:tasked_id]
  belongs_to :tasked_by, :class => User, :child_key => [:tasked_by_id]
  
  validates_present :tasked_id, :body
  validates_is_unique :body, :scope => :tasked_id,
      :message => "already tasked this!"
  
  validates_with_method :existing_user_id
  
  
  def existing_user_id
    in_db = User.first(self.tasked_id)
    if in_db
      return true
    else
      [false, "must be valid user"]
    end
  end
  
  def completed_tasks
    self.get(:status => 1)
  end
  
  def deleted_tasks
    self.get(:status => -1)
  end
  
  def active_tasks
    self.get(:status => 0)
  end
  
  
  
end