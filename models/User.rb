require 'helpers/helpers'
require 'digest/sha1'
require 'dm-validations'
require 'date'

class User
  include DataMapper::Resource
  
  property :id,			Integer, 	:serial => true
  property :login,		String,  	:key => true, :length => (3..40), :nullable => false
  property :hashed_password, 	String
  property :email,		String,		:format => :email_address
  property :salt,		String
  property :created_at,		DateTime,	:default => DateTime.now
  
  has n, :tasks
  
  validates_present :login, :email
  validates_is_unique :email, :login
  validates_with_method :login_not_reserved
  
  def login_not_reserved
    reserved_logins = ['admin','tasket','boner','alex','alexb','bisceglie','alexbisceglie','burton','task','tasked'] #hack some shit to generate interpolations of task...
    if prohibited_logins.include? self.login.downcase
      [false, "must be a valid login"]
    end
    return true
  end
  
  def password=(pass)
    @password = pass
    self.salt = Helpers::random_string(10) unless self.salt
    self.hashed_password = User.encrypt(@password, self.salt)
  end

  def self.encrypt(pass, salt)
    Digest::SHA1.hexdigest(pass + salt)
  end
  
  def self.authenticate(login, pass)
    u = User.first(:login => login)
    return nil if u.nil?
    return u if User.encrypt(pass, u.salt) == u.hashed_password
    nil
  end
end