class SessionsController < ApplicationController

	def new
	end

	def create
		user = User.find_by(email: params[:session][:email])
		if user && user.authenticate(params[:session][:password])
			flash[:sucess] = "Welcome #{user.name}"
			sign_in(user)
			redirect_to current_user
		else
			flash[:error] = "Username or password incorrect"
			render 'new'
		end
	end

	def destroy
		sign_out(current_user)
	end

end
