require 'test_helper'

class ArthistsControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:one)
    @other_user = users(:two)
    @arthist = arthists(:one)
  end


  test "destroyに失敗する（admin権限がない）" do
    log_in_as @other_user
    assert_no_difference 'Arthist.count' do
      delete arthist_path(@arthist)
    end
    assert_redirected_to arthists_path
  end

end
