require 'test_helper'

class ArthistIntegrationTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:one)
  end

  test "arthistとsingを同時に登録する" do
    log_in_as @user
    #youtubeの動画を投稿する
    get new_arthist_path
    assert_template 'arthists/new'
    assert_difference 'Arthist.count', 1 do
      assert_difference 'Sing.count', 1 do
        post arthists_path, params: {arthist: {name: "arthist　name",
                                               sings_attributes: {"0": {user_id: @user.id,
                                                                        name: "sing_name",
                                                                        link: "https://www.youtube.."}}
        }}
      end
    end
    assert_equal Arthist.last.name, "arthist name"
    assert_redirected_to sings_path
    #同じアーティストの曲(youtube)を投稿する(成功)
    get new_arthist_path
    assert_template 'arthists/new'
    assert_no_difference 'Arthist.count' do
      assert_difference 'Sing.count', 1 do
        post arthists_path, params: {arthist: {name: "arthist　name",
                                               sings_attributes: {"0": {user_id: @user.id,
                                                                        name: "sing_name",
                                                                        link: "https://www.youtube.."}}
        }}
      end
    end
    assert_equal Arthist.last.name, "arthist name"
    assert_redirected_to sings_path
    #instagramの動画を投稿する
    get new_arthist_path
    assert_template 'arthists/new'
    assert_difference 'Arthist.count', 1 do
      assert_difference 'Sing.count', 1 do
        post arthists_path, params: {arthist: {name: "arthist2_name",
                                               sings_attributes: {"0": {user_id: @user.id,
                                                                        name: "sing_name",
                                                                        link: "https://www.instagram.com/p/sample_test/?igshid=.."}}
        }}
      end
    end
    assert_redirected_to sings_path
    #同じアーティストの曲(instagram)を投稿する(成功)
    get new_arthist_path
    assert_template 'arthists/new'
    assert_no_difference 'Arthist.count' do
      assert_difference 'Sing.count', 1 do
        post arthists_path, params: {arthist: {name: "arthist2_name",
                                               sings_attributes: {"0": {user_id: @user.id,
                                                                        name: "sing_name",
                                                                        link: "https://www.instagram.com/p/sample_test/?igshid=.."}}
        }}
      end
    end
    assert_redirected_to sings_path
    #同じアーティストの曲を投稿する(失敗)
    get new_arthist_path
    assert_template 'arthists/new'
    assert_no_difference 'Arthist.count' do
      assert_no_difference 'Sing.count' do
        post arthists_path, params: {arthist: {name: "arthist_name",
                                               sings_attributes: {"0": {user_id: @user.id,
                                                                        name: "sing_name",
                                                                        link: ""}}
        }}
      end
    end
    assert_template 'arthists/new'
  end

  test "arthistとsingを同時に登録に失敗する" do
    log_in_as @user
    get new_arthist_path
    assert_template 'arthists/new'
    assert_no_difference 'Arthist.count' do
      assert_no_difference 'Sing.count' do
        post arthists_path, params: {arthist: {name: "",
                                               sings_attributes: {"0": {user_id: @user.id,
                                                                        name: "sing_name",
                                                                        link: "https://www.youtube.."}}
        }}
      end
    end
    assert_template 'arthists/new'
  end



end
