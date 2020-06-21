require 'test_helper'

class LikesControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:one)
    @arthist = arthists(:one)
    @sing = @arthist.sings.create!(user_id: @user.id,
                                   link: "https://www.youtube..")
  end

  test "お気に入りする（ログインしていない）" do
    assert_no_difference 'Like.count' do
      post likes_path ,params: {user_id: @user.id,
                                sing_id: @sing.id}
    end
    assert_redirected_to new_session_path
  end

  test "お気に入り解除する（ログインしていない）" do
    @user.likes.create(sing_id: @sing.id)
    assert_no_difference 'Like.count' do
      delete like_path(@sing)
    end
    assert_redirected_to new_session_path
  end


end
