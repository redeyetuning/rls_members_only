module SessionsHelper

	def sign_in(user)
		remember_token = User.new_token
		cookies.permanent[:remember_token] = remember_token
		user.update_attribute(:remember_token, User.encrypt(remember_token))
	end

end
