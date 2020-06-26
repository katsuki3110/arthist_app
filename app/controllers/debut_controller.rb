class DebutController < ApplicationController

  before_action :logged_in_user, only: [:create, :destroy]
  before_action :debut

  def index
    @arthists = Arthist.order(name: "DESC").where(debut: true)
  end

  def create
    @arthist = Arthist.find_by(id: params[:id])
    if @arthist.present?
      @arthist.update(debut: true, debut_date: Date.today)
      render 'debut.js.erb'
    else
      redirect_to root_path
    end
  end

  def destroy
    @arthist = Arthist.find_by(id: params[:id])
    if @arthist.present?
      @arthist.update(debut: false, debut_date: nil)
      render 'debut.js.erb'
    else
      redirect_to root_path
    end
  end
  
end
