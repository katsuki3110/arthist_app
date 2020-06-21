class LikesController < ApplicationController
  before_action :logged_in_user

  def create
    like = current_user.likes.create(sing_id: params[:sing_id])
    @sing = like.sing
    render 'like.js.erb'
  end

  def destroy
    like = current_user.likes.find_by(sing_id: params[:id])
    if like.present?
      @sing = like.sing
      like.destroy
      render 'like.js.erb'
    else
      redirect_to root_path
    end
  end


end
