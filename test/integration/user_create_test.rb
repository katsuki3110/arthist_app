require 'test_helper'

class UserCreateTest < ActionDispatch::IntegrationTest

  test "新規登録に成功する" do
    get new_user_path
    assert_template 'users/new'
    assert_difference 'User.count', 1 do
      post users_path, params: { user: { name:  "test",
                                         email: "test@test.com",
                                         password:              "password",
                                         password_confirmation: "password"}}
    end
    assert_not flash.empty?
    assert_redirected_to root_path
  end

  test "新規登録に失敗する" do
    get new_user_path
    assert_template 'users/new'
    assert_no_difference 'User.count' do
      post users_path, params: { user: { name:  " ",
                                         email: " ",
                                         password:              "password",
                                         password_confirmation: "invalid"}}
    end
    assert_template 'users/new'
  end

end
