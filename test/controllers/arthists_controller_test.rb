require 'test_helper'

class ArthistsControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:one)
    @other_user = users(:two)
    @arthist = arthists(:one)
  end

  test "showに失敗する（存在しないarthist）" do
    get arthist_path(id: Arthist.last.id + 1)
    assert_redirected_to arthists_path
  end

  test "newに失敗する（ログインしていない）" do
    get new_arthist_path
    assert_redirected_to new_session_path
  end

  test "createに失敗する（ログインしていない）" do
    assert_no_difference 'Arthist.count' do
      assert_no_difference 'Sing.count' do
        post arthists_path, params: {arthist: {name: "arthist_name",
                                               sings_attributes:{"0": {user_id: @user.id,
                                                                       name: "sing_name",
                                                                       link: "sing_link"}}
        }}
      end
    end
    assert_redirected_to new_session_path
  end

  test "初登録createに失敗する(youtube、instagram以外場合)" do
    log_in_as @user
    get new_arthist_path
    assert_no_difference 'Arthist.count' do
      assert_no_difference 'Sing.count' do
        post arthists_path, params: {arthist: {name: "arthist_name",
                                               sings_attributes: {"0": {user_id: @user.id,
                                                                        name: "sing_name",
                                                                        link: "https://www.error.."}}
        }}
      end
    end
    assert_template 'arthists/new'
  end

  test "初登録createに失敗する(validationエラー)" do
    log_in_as @user
    get new_arthist_path
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

  test "2回目移行createに失敗する(youtube、instagram以外の場合)" do
    log_in_as @user
    @arthist.save
    get new_arthist_path
    assert_no_difference 'Arthist.count' do
      assert_no_difference 'Sing.count' do
        post arthists_path, params: {arthist: {name: @arthist.name,
                                               sings_attributes: {"0": {user_id: @user.id,
                                                                        name: "sing_name",
                                                                        link: "https://www.error.."}}
        }}
      end
    end
    assert_template 'arthists/new'
  end

  test "2回目移行createに失敗する(validationエラー)" do
    log_in_as @user
    @arthist.save
    get new_arthist_path
    assert_no_difference 'Arthist.count' do
      assert_no_difference 'Sing.count' do
        post arthists_path, params: {arthist: {name: @arthist.name,
                                               sings_attributes: {"0": {user_id: @user.id,
                                                                        name: "sing_name",
                                                                        link: ""}}
        }}
      end
    end
    assert_template 'arthists/new'
  end

  test "editに失敗する（ログインしていない）" do
    get edit_arthist_path(@arthist)
    assert_redirected_to new_session_path
  end

  test "editに失敗する(存在しないarthist)" do
    log_in_as @user
    get edit_arthist_path(id: Arthist.last.id + 1)
    assert_redirected_to arthists_path
  end

  test "updateに失敗する（ログインしていない）" do
    patch arthist_path(@arthist), params: {arthist: {name: "arthist_name",
                                                     instagram_link: "instagram_link",
                                                     youtube_link:   "youtube_link"}}
    assert_redirected_to new_session_path
  end

  test "updateに失敗する（存在しないarthist）" do
    log_in_as @user
    patch arthist_path(id: Arthist.last.id + 1), params: {arthist: {name: "arthist_name",
                                                                    instagram_link: "instagram_link",
                                                                    youtube_link:   "youtube_link"}}
    assert_redirected_to root_path
  end

  test "updateに失敗する（validationエラー）" do
    log_in_as @user
    patch arthist_path(@arthist), params: {arthist: {name: "",
                                                     instagram_link: "instagram_link",
                                                     youtube_link:   "youtube_link"}}
    assert_template 'arthists/edit'
  end

  test "destroyに失敗する（admin権限がない）" do
    log_in_as @other_user
    assert_no_difference 'Arthist.count' do
      delete arthist_path(@arthist)
    end
    assert_redirected_to arthists_path
  end

  test "destroyに失敗する（存在しないarthist）" do
    log_in_as @user
    assert_no_difference 'Arthist.count' do
      delete arthist_path(id: Arthist.last.id + 1)
    end
    assert_redirected_to root_path
  end

  test "index_月初処理(デビューしているアーティストを削除)" do
    @arthist.debut = true
    @arthist.debut_date = Date.today.prev_month
    @arthist.save
    if Date.today == Date.today.beginning_of_month
      assert_difference 'Arthist.count', -1 do
        get arthists_path
      end
    end
  end

  test "show_月初処理(デビューしているアーティストを削除)" do
    @arthist.debut = true
    @arthist.debut_date = Date.today.prev_month
    @arthist.save
    if Date.today == Date.today.beginning_of_month
      assert_difference 'Arthist.count', -1 do
        get arthist_path(id: 1)
      end
    end
  end

  test "new_月初処理(デビューしているアーティストを削除)" do
    log_in_as @user
    @arthist.debut = true
    @arthist.debut_date = Date.today.prev_month
    @arthist.save
    if Date.today == Date.today.beginning_of_month
      assert_difference 'Arthist.count', -1 do
        get new_arthist_path
      end
    end
  end

  test "create_月初処理(デビューしているアーティストを削除)" do
    log_in_as @user
    @arthist.debut = true
    @arthist.debut_date = Date.today.prev_month
    @arthist.save
    if Date.today == Date.today.beginning_of_month
      assert_difference 'Arthist.count', -1 do
        post arthists_path, params: {arthist: {name: "arthist_name",
                                               sings_attributes: {"0": {user_id: @user.id,
                                                                        name: "sing_name",
                                                                        link: "sing_link"}}
        }}
      end
    end
  end

  test "edit_月初処理(デビューしているアーティストを削除)" do
    log_in_as @user
    @arthist.debut = true
    @arthist.debut_date = Date.today.prev_month
    @arthist.save
    if Date.today == Date.today.beginning_of_month
      assert_difference 'Arthist.count', -1 do
        get edit_arthist_path(id: 1)
      end
    end
  end

  test "update_月初処理(デビューしているアーティストを削除)" do
    log_in_as @user
    @arthist.debut = true
    @arthist.debut_date = Date.today.prev_month
    @arthist.save
    if Date.today == Date.today.beginning_of_month
      assert_difference 'Arthist.count', -1 do
        patch arthist_path(@arthist), params: {arthist: {name: "arthist_name",
                                                         instagram_link: "instagram_link",
                                                         youtube_link:   "youtube_link"}}
      end
    end
  end

  test "destroy_月初処理(デビューしているアーティストを削除)" do
    log_in_as @user
    @arthist.debut = true
    @arthist.debut_date = Date.today.prev_month
    @arthist.save
    if Date.today == Date.today.beginning_of_month
      assert_difference 'Arthist.count', -1 do
        delete arthist_path(id: 1)
      end
    end
  end

  test "image_editに失敗する（ログインしていない）" do
    @arthist.save
    get edit_image_arthist_path(@arthist)
    assert_redirected_to new_session_path
  end

  test "image_editに失敗する（存在しないarthist）" do
    log_in_as @user
    @arthist.save
    get edit_image_arthist_path(id: Arthist.last.id + 1)
    assert_redirected_to arthists_path
  end

  test "image_updateに失敗する（ログインしていない）" do
    @arthist.save
    patch update_image_arthist_path(@arthist),params:{image:{image: "defalt.png"}}
    assert_redirected_to new_session_path
  end

  test "image_updateに失敗する（存在しないarthist）" do
    log_in_as @user
    @arthist.save
    patch update_image_arthist_path(Arthist.last.id + 1), params: {image: {image: "default.png"}}
    assert_redirected_to root_path
  end

end
