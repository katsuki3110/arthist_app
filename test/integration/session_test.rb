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

  test "ログインする（資格情報の保持）" do
    log_in_as(@user, remember_me: "1")
    assert_not_empty cookies[:remember_token]
  end

  test "ログインする（資格情報の保持しない）" do
    #cookie保存
    log_in_as(@user, remember_me: "1")
    delete session_path(@user)
    #cookie保存しない
    log_in_as(@user, remember_me: "0")
    assert_empty cookies[:remember_token]
  end

end
