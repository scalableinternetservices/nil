class SearchesController < ApplicationController
    #search action
  def search
    @restaurants = Restaurant.search(params[:search])
    @foods = Food.search(params[:search])
  end
end
