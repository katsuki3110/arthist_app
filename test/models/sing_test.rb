require 'test_helper'

class SingTest < ActiveSupport::TestCase

  def setup
    @sing = sings(:one)
  end

  test "linkは空白でない" do
    @sing.link = "  "
    assert_not @sing.valid?
  end

end
