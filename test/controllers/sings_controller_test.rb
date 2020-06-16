require 'test_helper'

class SingsControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:one)
    @other_user = users(:two)
    @sing = sings(:one)
    @other_sing = sings(:two)
  end

  test "sing削除に失敗する（ログインしていない）" do
    assert_no_difference 'Sing.count' do
      delete sing_path(@sing)
    end
    assert_redirected_to new_session_path
  end

  test "sing削除に失敗する（他ユーザー投稿のsing）" do
    log_in_as @user
    assert_no_difference 'Sing.count' do
      delete sing_path(@other_sing)
    end
  end

end
