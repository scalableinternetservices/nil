class UsersController < ApplicationController
	def login
		render layout: false
	end

	def register
		render layout: false
		# After complete common registration, please redirect browser to setting_customer, setting_rest respectively.
	end

	def logout
	end

	def setting
	end

	def setting_customer
	end

	def setting_rest
	end

end
