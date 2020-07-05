module ArthistsHelper

  def video_judge(sing)
    if sing.link[12] == "y" || sing.link[8] == "y"
      #youtubeを投稿
      sing.link = sing.link.last(11)
      sing.video_flg = 1
    elsif sing.link[12] == "i"
      #instagramを投稿
      if sing.link[26] == "p"
        sing.link = sing.link[28,11]
      elsif sing.link[26, 2] == "tv"
        #IGTV
        sing.link = sing.link[29,11]
      end
      sing.video_flg = 2
    else
      flash[:danger] = "指定のリンクはシェア出来ません"
      sing.video_flg = 0
    end
  end

end
