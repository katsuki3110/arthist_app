require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:one)
  end

  test "ログイン失敗する（メールが存在しない）" do
    post sessions_path params:{ session: {email: "",
                                          password: "password"}}
    assert_not flash.empty?
    assert_template 'sessions/new'
  end

  test "ログイン失敗する（パスワードが不一致）" do
    post sessions_path params:{ session: {email: "test@test.com",
                                          password: "invalid"}}
    assert_not flash.empty?
    assert_template 'sessions/new'
  end

end
