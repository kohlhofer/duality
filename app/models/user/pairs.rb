class User < ActiveRecord::Base
  has_many :pairs, :foreign_key => 'creator_id', :dependent => :nullify
  has_many :choices, :dependent => :destroy
  has_many :chosen_pairs,
    :class_name => 'Pair',
    :through => :choices,
    :source => :pair
end