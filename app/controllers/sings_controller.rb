class SingsController < ApplicationController
  before_action :logged_in_user, only: :destroy
  before_action :correct_user,   only: :destroy
  before_action :debut

  def index
    @like_flg = params[:like_flg]
    if @like_flg == "1"
      @sings = current_user.like_sings.order(created_at: "DESC").page(params[:page]).per(6)
      @title = "Likes"
    else
      @sings = Sing.all.order(created_at: "DESC").page(params[:page]).per(6)
      @title = "Sings"
    end
    @sings_flg = "1"
  end

  def destroy
    @sing.destroy
    flash[:success] = "削除しました"
    redirect_to sings_path
  end

  private

    def correct_user
      @sing = current_user.sings.find_by(id: params[:id])
      redirect_to root_path unless @sing.present?
    end

end
