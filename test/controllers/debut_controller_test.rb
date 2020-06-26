require 'test_helper'

class DebutControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:one)
    @arthist = arthists(:one)
    @notExist_arthist = arthists(:two)
  end

  test "index_月初処理(デビューしているアーティストを削除)" do
    @arthist.debut = true
    @arthist.save
    if Date.today == Time.current.beginning_of_month
      assert_difference 'Arthist.count', -1 do
        get debut_index_path
      end
    end
  end

  test "updateに失敗する（ログインしていない）" do
    patch debut_path(@arthist)
    assert_redirected_to new_session_path
  end

  test "update_月初処理(デビューしているアーティストを削除)" do
    @arthist.debut = true
    @arthist.save
    if Date.today == Time.current.beginning_of_month
      assert_difference 'Arthist.count', -1 do
        patch debut_path(@arthist)
      end
    end
  end

  test "updateに失敗する（対象のarthistが存在しない）" do
    log_in_as @user
    @notExist_arthist.id = Arthist.last.id + 1
    patch debut_path(@notExist_arthist)
    assert_redirected_to root_path
    assert_not_equal @notExist_arthist.debut, true
  end


end
