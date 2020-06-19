class ApplicationController < ActionController::Base
  include SessionsHelper

  private

    def logged_in_user
      unless logged_in?
        flash[:danger] = "ログインしてください"
        redirect_to new_session_path
      end
    end

    def debut
      #月初にデビューしているアーティストは削除
      if Date.today == Time.current.beginning_of_month
        @arthists = Arthist.where(debut: true)
        @arthists.destroy_all
      end
    end

end
