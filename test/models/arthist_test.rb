require 'test_helper'

class ArthistTest < ActiveSupport::TestCase

  def setup
    @arthist = arthists(:one)
  end

  test "nameは空白でない" do
    @arthist.name = "  "
    assert_not @arthist.valid?
  end

  test "arthistが削除されれれば紐づくsingは削除される" do
    @arthist.save
    @arthist.sings.create!(name: "test",
                           link: "test_link")
    assert_difference 'Sing.count', -1 do
      @arthist.destroy
    end
  end

end
