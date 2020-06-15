class ArthistsController < ApplicationController
  before_action :arthist_dup,         only: :create
  before_action :current_user_admin?, only: :destroy

  def index
    @arthists = Arthist.order(name: "DESC").all
  end

  def show
    @arthist = Arthist.find_by(id: params[:id])
    if @arthist.present?
      @sings = @arthist.sings
    else
      redirect_to arthists_path
    end
  end

  def new
    @arthist = Arthist.new
    @arthist.sings.build
  end

  def create
    @arthist = Arthist.new(arthist_params)
    if @arthist.save
      flash[:info] = "シェアされました"
      redirect_to sings_path
    else
      render 'arthists/new'
    end
  end

  def edit
    @arthist = Arthist.find_by(id: params[:id])
    unless @arthist.present?
      redirect_to arthists_path
    end
  end

  def update
    @arthist = Arthist.find_by(id: params[:id])
    if @arthist.update(arthist_edit_params)
      flash[:success] = "更新しました"
      redirect_to arthist_path(@arthist)
    else
      render 'arthists/edit'
    end
  end

  def destroy
    #admin権限者のみ
    @arthist = Arthist.find_by(id: params[:id])
    if @arthist.present?
      @arthist.destroy
      flash[:info] = "削除しました"
      redirect_to arthists_path
    else
      redirect_to root_path
    end
  end


  private

    def arthist_params
      params.require(:arthist).permit(:name,
                                      sings_attributes:[:id,
                                                        :link,
                                                        :_destroy])
    end

    def arthist_edit_params
      params.require(:arthist).permit(:name, :link)
    end

    def arthist_dup
      @arthist = Arthist.find_by(name: params[:arthist][:name])
      if @arthist.present?
        sing = @arthist.sings.build(link: params[:arthist][:sings_attributes][:"0"][:link])
        if sing.save
          flash[:info] = "シェアしました"
          redirect_to sings_path
        else
          render 'arthists/new'
        end
      end
    end

    def current_user_admin?
      #ログインユーザーはadmin?
      redirect_to arthists_path unless current_user.admin?
    end


end
