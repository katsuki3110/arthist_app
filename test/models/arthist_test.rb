require 'test_helper'

class ArthistTest < ActiveSupport::TestCase

  def setup
    @arthist = arthists(:one)
  end

  test "nameは空白でない" do
    @arthist.name = "  "
    assert_not @arthist.valid?
  end

end
