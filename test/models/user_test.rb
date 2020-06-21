require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = users(:one)
    @sing = sings(:one)
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

  test "emailは大小区別しない" do
    other_mail = "One@ExamPLe"
    @user.email = other_mail
    @user.save
    assert_equal other_mail.downcase, @user.reload.email
  end

  test "passwordは空白でない" do
    @user.password = "  "
    assert_not @user.valid?
  end

  test "passwordは6文字以上である" do
    @user.password = "a" * 5
    assert_not @user.valid?
  end

  test "userが削除されても紐づくsingは削除されない" do
    @user.save
    Arthist.create!(name: "arthist_name",
                    sings_attributes:{"0": {user_id: @user.id,
                                            link: "sing_link"}})
    assert_no_difference 'Arthist.count' do
      assert_no_difference 'Sing.count' do
        @user.destroy
      end
    end
  end

  test "userが削除されれば紐づくlikeは削除される" do
    @user.save
    @sing.save
    @user.likes.create!(sing_id: @sing.id)
    assert_difference 'Like.count', -1 do
      @user.destroy
    end
  end

end
