class Choice < ActiveRecord::Base
  validates_presence_of :user_id
  validates_presence_of :pair_id
  validates_presence_of :item
  validates_inclusion_of :item, :in => [1, 2]
  
  belongs_to :user
  belongs_to :pair
end
