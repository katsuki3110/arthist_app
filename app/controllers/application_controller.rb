class ApplicationController < ActionController::Base
  include SessionsHelper
  include ArthistsHelper

  private

    def logged_in_user
      unless logged_in?
        flash[:danger] = "ログインしてください"
        redirect_to new_session_path
      end
    end

    def already_logged_in
      if logged_in?
        flash[:info] = "既にログインしています"
        redirect_to root_path
      end
    end

    def debut
      #月初にデビューしているアーティストは削除
      #月初 かつ 月初にデビューしたアーティスト以外
      if Date.today == Date.today.beginning_of_month
        @arthists = Arthist.where(debut: true).where.not(debut_date: Date.today)
        @arthists.destroy_all
      end
    end

end
