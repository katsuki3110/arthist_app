class ArthistsController < ApplicationController
  before_action :logged_in_user,      only: [:new, :create]
  before_action :arthist_dup,         only: :create
  before_action :current_user_admin?, only: :destroy
  before_action :debut

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
    #初登録のarthist
    @arthist = Arthist.new(changed_space(arthist_params))
    sing = @arthist.sings.last
    sing.user_id = current_user.id

    if sing.link[12] == "y"
      #youtubeを投稿
      sing.link = sing.link.last(11)
      sing.video_flg = 1
    elsif sing.link[12] == "i"
      #instagramを投稿
      sing.link = sing.link[28,11]
      sing.video_flg = 2
    else
      flash[:danger] = "指定のリンクはシェア出来ません"
      sing.video_flg = 0
    end

    if sing.video_flg != 0 && @arthist.save
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

  def debut_create
    @arthist = Arthist.find_by(id: params[:id])
    if @arthist.present?
      @arthist.update(debut: true, debut_date: Date.today)
      render 'debut.js.erb'
    else
      redirect_to root_path
    end
  end

  def debut_destroy
    @arthist = Arthist.find_by(id: params[:id])
    if @arthist.present?
      @arthist.update(debut: false, debut_date: nil)
      render 'debut.js.erb'
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

    def changed_space(arthist_params)
      #アーティスト名の全角スペースを半角スペースに変換
      arthist_params.each do |key, value|
        if key == "name"
          arthist_params[key] = value.tr("　", " ")
        end
      end
    end

    def arthist_dup
      @arthist = Arthist.find_by(name: changed_space(arthist_params)[:name])
      if @arthist.present?
        #arthistが登録ずみ
        sing = @arthist.sings.build(user_id: current_user.id,
                                    link: arthist_params[:sings_attributes][:"0"][:link])

        if sing.link[12] == "y"
          #youtubeを投稿
          sing.link = sing.link.last(11)
          sing.video_flg = 1
        elsif sing.link[12] == "i"
          #instagramを投稿
          sing.link = sing.link[28,11]
          sing.video_flg = 2
        else
          flash[:danger] = "指定のリンクはシェア出来ません"
          sing.video_flg = 0
        end

        if sing.video_flg != 0 && sing.save
          flash[:info] = "シェアされました"
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
