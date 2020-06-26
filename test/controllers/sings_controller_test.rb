require 'test_helper'

class SingsControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:one)
    @other_user = users(:two)
    @arthist = arthists(:one)
    @sing = @arthist.sings.create!(user_id: @user.id,
                                   name: "sing_name",
                                   link: "sing_link")
    @other_sing = sings(:two)
  end

  test "index_月初処理(デビューしているアーティストを削除)" do
    @arthist.debut = true
    @arthist.save
    if Date.today == Time.current.beginning_of_month
      assert_difference 'Arthist.count', -1 do
        assert_difference 'Sing.count', -1 do
          get sings_path
        end
      end
    end
  end

  test "destroyに失敗する（ログインしていない）" do
    assert_no_difference 'Sing.count' do
      delete sing_path(@sing)
    end
    assert_redirected_to new_session_path
  end

  test "destroy_月初処理(デビューしているアーティストを削除)" do
    @arthist.debut = true
    @arthist.save
    if Date.today == Time.current.beginning_of_month
      assert_difference 'Arthist.count', -1 do
        assert_difference 'Sing.count', -1 do
          delete sings_path(@sing)
        end
      end
    end
  end

  test "destroyに失敗する（他ユーザー投稿のsing）" do
    log_in_as @user
    assert_no_difference 'Sing.count' do
      delete sing_path(@other_sing)
    end
    assert_redirected_to root_path
  end

end
