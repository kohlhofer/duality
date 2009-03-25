class PairsController < ApplicationController
  
  def index
    @pairs = Pair.all
  end
  
  def choose
  end
  
end
