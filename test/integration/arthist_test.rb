require 'test_helper'

class ArthistIntegrationTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:one)
    @arthist = arthists(:one)
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

  test "arthistの編集を行う" do
    log_in_as @user
    @arthist.save
    get edit_arthist_path(@arthist)
    assert_template 'arthists/edit'
    #名前とリンクの編集（失敗）
    patch arthist_path(@arthist), params: {arthist: {name: "",
                                                     link: "arthist_link"}}
    assert_template 'arthists/edit'
    #名前とリンクの編集（成功）
    patch arthist_path(@arthist), params: {arthist: {name: "arthist_name",
                                                     link: "arthist_link"}}
    assert_redirected_to arthist_path(@arthist)
    #画像の編集（成功）
    get edit_arthist_path(@arthist)
    get edit_image_arthist_path(@arthist)
    patch update_image_arthist_path(@arthist), params: {image: {image: "default.png"}}
    assert_redirected_to arthist_path(@arthist)
  end



end
