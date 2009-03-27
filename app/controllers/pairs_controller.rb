class PairsController < ApplicationController

  before_filter :require_user, :only => :create
  
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
      session[:pair_ids].delete(@pair.id)
    
      if @next_pair = Pair.unanswered_by(User.current).random.first(:conditions => ["pairs.id NOT IN (?)", session[:pair_ids]])
        session[:pair_ids] << @next_pair.id
      end
    else
      render :update do |page|
        page.alert "Please log in!"
      end
    end
  end

  def show
    @pair = Pair.find(params[:id], :include => :users)
  end
  
  def create
    @pair = User.current.pairs.build(params[:pair])
    if @pair.save
      render :update do |page|
        page.insert_html :top, "pairs", render(@pair)
        page[@pair].hide
        page[@pair].visual_effect :blind_down, :duration => "0.3"
        page["new_pair_form_status"].replace_html ""
      end
    else
      render :update do |page|
        page["new_pair_form_status"].replace_html "Failed :-("
      end
    end
  end
  
end
