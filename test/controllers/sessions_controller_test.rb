require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:one)
  end

  test "newに失敗する(既にログインずみ)" do
    log_in_as @user
    get new_session_path
    assert_redirected_to root_path
  end

  test "create失敗する（メールが存在しない）" do
    post sessions_path params:{ session: {email: "",
                                          password: "password"}}
    assert_not flash.empty?
    assert_template 'sessions/new'
  end

  test "create失敗する（パスワードが不一致）" do
    post sessions_path params:{ session: {email: "test@test.com",
                                          password: "invalid"}}
    assert_not flash.empty?
    assert_template 'sessions/new'
  end

  test "createに失敗する(既にログインずみ)" do
    log_in_as @user
    post sessions_path params:{ session: {email: "test@test.com",
                                          password: "password"}}
    assert_redirected_to root_path
  end

  test "destroy失敗する（ログインしていない）" do
    delete session_path(@user)
    assert_redirected_to new_session_path
  end

end
