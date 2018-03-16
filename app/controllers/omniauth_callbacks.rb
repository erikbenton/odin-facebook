class Auth::OmniauthCallbacksController < ApplicationController
	def facebook
		@user = User.from_omniauth(omniauth_params)
		sign_in_and_redirect @user
	end

	def failure
		flash[:danger] = "Unable to sign in"
		redirect_to root
	end

	private
		def omniauth_params
			request.env["omniauth.auth"]
		end
end