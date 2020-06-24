require 'test_helper'

class SingTest < ActiveSupport::TestCase

  def setup
    @sing = sings(:one)
  end

  test "nameは空白でない" do
    @sing.name = "  "
    assert_not @sing.valid?
  end

  test "nameは最大45文字" do
    @sing.name = "a"*46
    assert_not @sing.valid?
  end

  test "linkは空白でない" do
    @sing.link = "  "
    assert_not @sing.valid?
  end

end
