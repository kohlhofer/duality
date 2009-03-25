class PairsController < ApplicationController
  
  def index
    @pairs = Pair.all
  end
  
end
