class ApplicationController < ActionController::Base

    def logout
        current_user.reset_session_token!
        session[:session_token] = nil
        current_user = nil
    end
end
