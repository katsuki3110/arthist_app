require 'test_helper'

class ArthistsControllerTest < ActionDispatch::IntegrationTest

  test "newに失敗する（ログインしていない）" do
    get new_arthist_path
    assert_redirected_to new_session_path
  end

  test "createに失敗する（ログインしていない）" do
    assert_no_difference 'Arthist.count' do
      assert_no_difference 'Sing.count' do
        post arthists_path, params: {arthist: {name: "arthist_name",
                                               sings_attributes: {"0": {name: "sing_name",
                                                                        link: "sing_link"}}
        }}
      end
    end
    assert_redirected_to new_session_path
  end

end
