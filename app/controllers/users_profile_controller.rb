class UsersProfileController < ApplicationController
	def show
		 @user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])
	end			
end
