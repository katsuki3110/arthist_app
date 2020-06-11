require 'test_helper'

class SessionTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:one)
  end

  test "ログインしてログアウトする" do
    get new_session_path
    assert_template 'sessions/new'
    post sessions_path, params: {session: {email:    "one@example",
                                           password: "password"}}
    assert_redirected_to root_path
    delete session_path(@user)
    assert_not flash.empty?
    assert_redirected_to root_path
  end

  test "ログイン失敗する" do
    get new_session_path
    assert_template 'sessions/new'
    post sessions_path, params: {session: {email:    "test@example.com",
                                           password: "invalid"}}
    assert_template 'sessions/new'
  end

end
