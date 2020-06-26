require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest

    test "createに失敗する（validationエラー）" do
      post users_path, params: {user: {name:  "user_name",
                                        email: "",
                                        password:              "password",
                                        password_confirmation: "invalid"}}
      assert_template 'users/new'
    end

end
