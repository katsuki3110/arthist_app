class ArthistsController < ApplicationController
  before_action :logged_in_user
  before_action :arthist_dup,    only: :create

  def new
    @arthist = Arthist.new
    @arthist.sings.build
  end

  def create
    @arthist = current_user.arthists.build(arthist_params)
    if @arthist.save
      flash[:info] = "シェアされました"
      redirect_to sings_path
    else
      render 'new'
    end
  end

  private

    def arthist_params
      params.require(:arthist).permit(:name,
                                      sings_attributes:[:id,
                                                        :name,
                                                        :link,
                                                        :_destroy])
    end

    def arthist_dup
      @arthist = Arthist.find_by(name: params[:arthist][:name])
      if @arthist.present?
        sing = @arthist.sings.build(name: params[:arthist][:sings_attributes][:"0"][:name],
                                    link: params[:arthist][:sings_attributes][:"0"][:link])
        if sing.save
          flash[:info] = "シェアしました"
          redirect_to sings_path
        else
          render 'arthists/new'
        end
      end
    end

end
