require 'test_helper'

class SingsControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:one)
    @other_user = users(:two)
    @sing = sings(:one)
    @other_sing = sings(:two)
  end

  test "editに失敗する（ログインしていない）" do
    get edit_sing_path(@sing)
    assert_redirected_to new_session_path
  end

  test "editに失敗する（他ユーザのsingをedit）" do
    log_in_as @user
    get edit_sing_path(@other_sing)
    assert_redirected_to root_path
  end

  test "updateに失敗する（ログインしていない）" do
    patch sing_path(@sing), params: {sing:{name: "sing_name",
                                           link: "sing_link"}}
    assert_redirected_to new_session_path
  end

  test "updateに失敗する（他ユーザのsingをupdate）" do
    log_in_as @user
    patch sing_path(@other_sing), params: {sing:{name: "sing_name",
                                                 link: "sing_link"}}
    assert_redirected_to root_path
  end

  test "destroyに失敗する（ログインしていない）" do
    delete sing_path(@sing)
    assert_redirected_to new_session_path
  end

  test "destroyに失敗する（他ユーザのsingをdestroy）" do
    log_in_as @user
    delete sing_path(@other_sing)
    assert_redirected_to root_path
  end


end
