require 'test_helper'

class LikesControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:one)
    @arthist = arthists(:one)
    @sing = @arthist.sings.create!(user_id: @user.id,
                                   name: "sing_name",
                                   link: "https://www.youtube..")
  end

  test "createに失敗する（ログインしていない）" do
    assert_no_difference 'Like.count' do
      post likes_path ,params: {user_id: @user.id,
                                sing_id: @sing.id}
    end
    assert_redirected_to new_session_path
  end

  test "destroyに失敗する（ログインしていない）" do
    @user.likes.create(sing_id: @sing.id)
    assert_no_difference 'Like.count' do
      delete like_path(@sing)
    end
    assert_redirected_to new_session_path
  end

  test "destroyに失敗する（存在しないsing）" do
    log_in_as @user
    @user.likes.create(sing_id: @sing.id)
    assert_no_difference 'Like.count' do
      delete like_path(Sing.last.id + 1)
    end
    assert_redirected_to root_path
  end


end
