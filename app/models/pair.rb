class Pair < ActiveRecord::Base
  validates_presence_of :item_1, :item_2
  belongs_to :creator, :class_name => 'User'   # can be nil!
  has_many :choices, :dependent => :destroy

  def items
    [self.item_1, self.item_2]
  end
  
  def items=(list)
    self.item_1, self.item_2 = list
  end
  
  def self.find_next_for(user)
    self.random.find(:first)  # XXX
  end
end
