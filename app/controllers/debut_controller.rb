class DebutController < ApplicationController

  before_action :logged_in_user, only: [:update]
  before_action :debut

  def index
    @arthists = Arthist.order(debut_date: "ASC", name: "DESC").where(debut: true)
  end

  def update
    @arthist = Arthist.find_by(id: params[:id])
    if @arthist.present?
      if params[:debut_flg].present?
        @arthist.update(debut: true, debut_date: Date.today)
      else
        @arthist.update(debut: false, debut_date: nil)
      end
      render 'debut.js.erb'
    else
      redirect_to root_path
    end
  end

end
