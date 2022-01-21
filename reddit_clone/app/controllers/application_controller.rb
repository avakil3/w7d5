class ApplicationController < ActionController::Base

	protect_from_forgery with: :exception

	helper_method :current_user, :logged_in?

	def current_user
		@current_user ||= User.find_by(session_token: session[:session_token])
	end

	def ensure_logged_in
		# if current_user
		# else #no current_user
		# 	redirect_to new_session_url
		# end
		redirect_to new_session_url if current_user.nil?
	end

	def login(user)
		@current_user = user
		session[:session_token] = user.reset_session_token!
	end

	def logged_in?
		!!current_user
		# !current_user.nil?
	end

    def logout
        current_user.reset_session_token!
        session[:session_token] = nil
        current_user = nil
    end
end
