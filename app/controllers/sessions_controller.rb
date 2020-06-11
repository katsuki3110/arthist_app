class SessionsController < ApplicationController
  before_action :logged_in_user, only: :destroy

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email])
    if user.present? && user.authenticate(params[:session][:password])
      flash[:success] = "ログインしました！"
      login user
      redirect_to root_path
    else
      flash[:danger] = "メールアドレスまたはパスワードが間違っています"
      render 'sessions/new'
    end
  end

  def destroy
    logout
    flash[:info] = "ログアウトしました"
    redirect_to root_path
  end

  private

    def logged_in_user
      unless logged_in?
        flash[:danger] = "ログインしてください"
        redirect_to new_session_path
      end
    end

end
