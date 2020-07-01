require 'test_helper'

class DebutTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:one)
    @arthist = arthists(:one)
  end

  test "デビューを報告し、取り消す" do
    log_in_as @user
    #デビューを報告する
    patch debut_path(id: @arthist.id, debut_flg: "1")
    assert_equal @arthist.reload.debut, true
    assert_template 'debut/_debut_form'
    #デビューを取り消す
    patch debut_path(@arthist)
    assert_equal @arthist.reload.debut, false
    assert_template 'debut/_debut_form'
  end

end
