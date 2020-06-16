require 'test_helper'

class ArthistsControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:one)
    @other_user = users(:two)
    @arthist = arthists(:one)
  end

  test "newに失敗する（ログインしていない）" do
    get new_arthist_path
    assert_redirected_to new_session_path
  end

  test "createに失敗する（ログインしていない）" do
    assert_no_difference 'Arthist.count' do
      assert_no_difference 'Sing.count' do
        post arthists_path, params: {arthist: {name: "arthist_name",
                                               sings_attributes:{"0":{link: "sing_link"}}
        }}
      end
    end
    assert_redirected_to new_session_path
  end


  test "destroyに失敗する（admin権限がない）" do
    log_in_as @other_user
    assert_no_difference 'Arthist.count' do
      delete arthist_path(@arthist)
    end
    assert_redirected_to arthists_path
  end

end
