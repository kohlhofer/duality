class User < ActiveRecord::Base
  has_many :pairs, :foreign_key => 'creator_id', :dependent => :nullify
end