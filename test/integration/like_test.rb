require 'test_helper'

class LikeIntegrationTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:one)
    @arthist = arthists(:one)
    @sing = @arthist.sings.create!(user_id: @user.id,
                                   link: "https://www.youtube..")
  end

  test "singをお気に入りして、解除する" do
    log_in_as @user
    #お気に入りする
    assert_difference 'Like.count', 1 do
      post likes_path, params:{user_id: @user.id,
                               sing_id: @sing.id}
    end
    #解除する
    assert_difference 'Like.count', -1 do
      delete like_path(@sing)
    end
  end

end
