class Pair < ActiveRecord::Base
  validates_presence_of :item_1, :item_2
  belongs_to :creator, :class_name => 'User'   # can be nil!
  has_many :choices, :dependent => :destroy
  has_many :users, :through => :choices

  named_scope :answered_by, lambda { |user| { 
    :include => :choices,
    :conditions => { 'choices.user_id' => user.id }
  }}
  
  named_scope :unanswered_by, lambda { |user| {
    :joins => "LEFT OUTER JOIN choices ON choices.pair_id = pairs.id AND choices.user_id = #{user.id.to_i}",
    :conditions => { 'choices.id' => nil }
  }}

  def items
    [self.item_1, self.item_2]
  end
  
  def items=(list)
    self.item_1, self.item_2 = list
  end
end
