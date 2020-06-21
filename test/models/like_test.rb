require 'test_helper'

class LikeTest < ActiveSupport::TestCase

  def setup
    @user = users(:one)
    @sing = sings(:one)
    @like = @user.likes.create!(sing_id: @sing.id)
  end

  test "user_idは空白でない" do
    @like.user_id = "  "
    assert_not @like.valid?
  end

  test "sing_idは空白でない" do
    @like.sing_id = "  "
    assert_not @like.valid?
  end

end
