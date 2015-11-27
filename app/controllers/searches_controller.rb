class SearchesController < ApplicationController
  before_action  :check_access

    #search action
  def search
      @restaurants = Rails.cache.fetch("search-restaurants-#{params[:search]}") do
          Restaurant.search(params[:search])
      end
      
      @foods = Food.search(params[:search])
  end

  private
  def check_access
  	if current_user.nil?
  		redirect_to '/' and return
  	end
  end
end
