require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:one)
  end

  test "newに失敗する(既にログインずみ)" do
    log_in_as @user
    get new_user_path
    assert_redirected_to root_path
  end

  test "createに失敗する(既にログインずみ)" do
    log_in_as @user
    post users_path, params: {user: {name:  "user_name",
                                      email: "email@test",
                                      password:              "password",
                                      password_confirmation: "password"}}
    assert_redirected_to root_path
  end

  test "createに失敗する（validationエラー）" do
    post users_path, params: {user: {name:  "user_name",
                                      email: "",
                                      password:              "password",
                                      password_confirmation: "invalid"}}
    assert_template 'users/new'
  end

end
