class PairsController < ApplicationController
  
  def index
    if User.current?
      @pairs = Pair.unanswered_by(User.current).random.limit(10)
    else
      @pairs = Pair.random.limit(3)
    end
    
    session[:pair_ids] = @pairs.map(&:id)
  end
  
  def choose
    if User.current?
      @pair = Pair.find(params[:id])
      @choice = Choice.find_or_initialize_by_user_id_and_pair_id(User.current.id, @pair.id)  # XXX: hardcoded user ID, nasty!
      @choice.item = params[:item]
      @choice.save!
      session[:pair_ids].delete(@choice.id)
    
      if @next_pair = Pair.unanswered_by(User.current).random.first(:conditions => ["pairs.id NOT IN (?)", session[:pair_ids]])
        session[:pair_ids] << @next_pair.id
      end
    else
      render :update do |page|
        page.alert "Please log in!"
      end
    end
  end
  
end
