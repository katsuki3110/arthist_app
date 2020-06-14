class SingsController < ApplicationController
  before_action :logged_in_user, only:[:edit, :update, :destroy]
  before_action :correct_user,   only:[:edit, :update, :destroy]

  def index
    @sings = Sing.order("RANDOM()").all
  end

  def show
    @sing = Sing.find_by(id: params[:id])
    unless @sing.present?
      redirect_to sings_path
    end
  end

  def edit
  end

  def update
    if @sing.update(sing_params)
      flash[:success] = "更新しました"
      redirect_to sing_path(@sing)
    else
      render 'sings/edit'
    end
  end

  def destroy
    @sing.destroy
    flash[:info] = "削除しました"
    redirect_to sings_path
  end

  private

    def sing_params
      params.require(:sing).permit(:name, :link)
    end

    def correct_user
      @sing = current_user.sings.find_by(id: params[:id])
      redirect_to root_path unless @sing.present?
    end


end
