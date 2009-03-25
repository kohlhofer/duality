class User < ActiveRecord::Base
  validates_presence_of :login
  validates_length_of :login, :within => 3..30
  validates_uniqueness_of :login
  
  validates_presence_of :email
  validates_uniqueness_of :email
  
  concerned_with :authentication
end
