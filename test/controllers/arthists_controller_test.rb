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
                                               sings_attributes:{"0": {user_id: @user.id,
                                                                       name: "sing_name",
                                                                       link: "sing_link"}}
        }}
      end
    end
    assert_redirected_to new_session_path
  end

  test "初投稿のアーティストの曲を登録する(失敗)" do
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

  test "destroyに失敗する（admin権限がない）" do
    log_in_as @other_user
    assert_no_difference 'Arthist.count' do
      delete arthist_path(@arthist)
    end
    assert_redirected_to arthists_path
  end

  test "index_月末処理(デビューしているアーティストを削除)" do
    @arthist.debut = true
    @arthist.save
    if Date.today == Time.current.beginning_of_month
      assert_difference 'Arthist.count', -1 do
        get arthists_path
      end
    end
  end

  test "show_月末処理(デビューしているアーティストを削除)" do
    @arthist.debut = true
    @arthist.save
    if Date.today == Time.current.beginning_of_month
      assert_difference 'Arthist.count', -1 do
        get arthist_path(id: 1)
      end
    end
  end

  test "new_月末処理(デビューしているアーティストを削除)" do
    @arthist.debut = true
    @arthist.save
    if Date.today == Time.current.beginning_of_month
      assert_difference 'Arthist.count', -1 do
        get new_arthist_path
      end
    end
  end

  test "create_月末処理(デビューしているアーティストを削除)" do
    @arthist.debut = true
    @arthist.save
    if Date.today == Time.current.beginning_of_month
      assert_difference 'Arthist.count', -1 do
        post arthists_path, params: {arthist: {name: "arthist_name",
                                               sings_attributes: {"0": {user_id: @user.id,
                                                                        name: "sing_name",
                                                                        link: "sing_link"}}
        }}
      end
    end
  end

  test "edit_月末処理(デビューしているアーティストを削除)" do
    @arthist.debut = true
    @arthist.save
    if Date.today == Time.current.beginning_of_month
      assert_difference 'Arthist.count', -1 do
        get edit_arthist_path(id: 1)
      end
    end
  end

  test "update_月末処理(デビューしているアーティストを削除)" do
    @arthist.debut = true
    @arthist.save
    if Date.today == Time.current.beginning_of_month
      assert_difference 'Arthist.count', -1 do
        patch arthist_path, params: {arthist: {name: "arthist_name",
                                               sings_attributes: {"0": {user_id: @user.id,
                                                                        name: "sing_name",
                                                                        link: "sing_link"}}
        }}
      end
    end
  end

  test "destroy_月末処理(デビューしているアーティストを削除)" do
    @arthist.debut = true
    @arthist.save
    if Date.today == Time.current.beginning_of_month
      assert_difference 'Arthist.count', -1 do
        delete arthist_path(id: 1)
      end
    end
  end

  test "debut_create_月末処理(デビューしているアーティストを削除)" do
    @arthist.debut = true
    @arthist.save
    if Date.today == Time.current.beginning_of_month
      assert_difference 'Arthist.count', -1 do
        post debut_create_arthist_path(id: 1)
      end
    end
  end

  test "debut_destroy_月末処理(デビューしているアーティストを削除)" do
    @arthist.debut = true
    @arthist.save
    if Date.today == Time.current.beginning_of_month
      assert_difference 'Arthist.count', -1 do
        delete debut_destroy_arthist_path(id: 1)
      end
    end
  end

end
