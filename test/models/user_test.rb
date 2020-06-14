require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(name:  "test",
                     email: "test@example",
                     password:              "password",
                     password_confirmation: "password")
  end

  test "name空白でない" do
    @user.name = "  "
    assert_not @user.valid?
  end

  test "nameは30文字以内" do
    @user.name = "a" * 31
    assert_not @user.valid?
  end

  test "emailは空白でない" do
    @user.email = "  "
    assert_not @user.valid?
  end

  test "emailは一意である" do
    other_user = @user.dup
    @user.save
    assert_not other_user.valid?
  end

  test "emailは一意である（大小区別しない）" do
    other_mail = "InvaLiD@ExamPLe"
    @user.email = other_mail
    @user.save
    assert_equal other_mail.downcase, @user.reload.email
  end

  test "passwordは空白でない" do
    @user.password = "  "
    assert_not @user.valid?
  end

  test "passwordは8文字以上である" do
    @user.password = "a" * 7
    assert_not @user.valid?
  end

  test "userが削除されても紐づくarthist,singは削除されない" do
    @user.save
    @user.arthists.create!(name: "test",
                           sings_attributes:[{name: "sing_name",
                                              link: "sing_link"}])
    assert_no_difference 'Arthist.count' do
      assert_no_difference 'Sing.count' do
        @user.destroy
      end
    end
  end

end