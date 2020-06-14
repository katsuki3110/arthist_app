class SessionsController < ApplicationController
  before_action :logged_in_user, only: :destroy

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email])
    if user.present? && user.authenticate(params[:session][:password])
      flash[:success] = "ログインしました！"
      login user
      params[:session][:remember_me] == "1"? remember(user):forget(user)
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


end
