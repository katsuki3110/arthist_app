require 'test_helper'

class ArthistTestTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:one)
    @arthist = arthists(:one)
  end

  test "createする際にarthistが既に重複する場合" do
    log_in_as @user
    @arthist.save
    assert_no_difference 'Arthist.count' do
      assert_difference 'Sing.count', 1 do
        post arthists_path, params: {arthist: {name: @arthist.name,
                                               sings_attributes: {"0": {name: "sing_name",
                                                                        link: "sing_link"}}
        }}
      end
    end
    assert_redirected_to sings_path
  end

  test "arthistとsingを同時に登録する" do
    log_in_as @user
    get new_arthist_path
    assert_template 'arthists/new'
    assert_difference 'Arthist.count', 1 do
      assert_difference 'Sing.count', 1 do
        post arthists_path, params: {arthist: {name: "arthist_name",
                                               sings_attributes: {"0": {name: "sing_name",
                                                                        link: "sing_link"}}
        }}
      end
    end
    assert_not flash.empty?
    assert_redirected_to sings_path
  end

  test "arthistとsingを同時に登録に失敗する" do
    log_in_as @user
    get new_arthist_path
    assert_template 'arthists/new'
    assert_no_difference 'Arthist.count' do
      assert_no_difference 'Sing.count' do
        post arthists_path, params: {arthist: {name: "",
                                               sings_attributes: {"0": {name: "",
                                                                        link: "sing_link"}}
        }}
      end
    end
    assert_template 'arthists/new'
  end



end
