class PairsController < ApplicationController
  
  def index
    @pairs = Pair.random.limit(3)
  end
  
  def choose
    if User.current.nil?
      render :update do |page|
        page.alert "Please log in!"
      end
    else
      @pair = Pair.find(params[:id])
      @choice = Choice.find_or_initialize_by_user_id_and_pair_id(User.current.id, @pair.id)  # XXX: hardcoded user ID, nasty!
      @choice.item = params[:item]
      @choice.save!
    
      @next_pair = Pair.find_next_for(User.current)
    end
  end
  
end
