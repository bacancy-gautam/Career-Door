class CitiesController < ApplicationController
  def index 
    @cities = CS.get(params[:country], params[:state])
    # binding.pry
  end
end
