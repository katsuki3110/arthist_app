class UsersController < ApplicationController
  before_action :already_logged_in

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:info] = "ようこそ"
      login @user
      redirect_to root_path
    else
      render 'new'
    end
  end

  private

    def user_params
      params.require(:user).permit(:name,
                                   :email,
                                   :password,
                                   :password_confirmation)
    end

    def already_logged_in
      if logged_in?
        flash[:info] = "既にログインしています"
        redirect_to root_path
      end
    end

end
