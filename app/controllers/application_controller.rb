class ApplicationController < ActionController::Base
  include SessionsHelper

  private

    def logged_in_user
      unless logged_in?
        flash[:danger] = "ログインしてください"
        redirect_to new_session_path
      end
    end
    
end
