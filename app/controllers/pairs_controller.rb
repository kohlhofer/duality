class PairsController < ApplicationController
  
  def index
    @pairs = Pair.all
  end
  
  def choose
    @pair = Pair.find(params[:id])
    @choice = Choice.find_or_initialize_by_user_id_and_pair_id(User.current.id, @pair.id)  # XXX: hardcoded user ID, nasty!
    @choice.item = params[:item]
    @choice.save!
  end
  
end
