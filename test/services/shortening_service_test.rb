require 'test_helper'

class ShorteningServiceTest < ActiveSupport::TestCase
  test "should properly shorten urls" do
    travel_to Time.new(2007, 1, 26, 3, 22, 45)
    assert_equal "gbtx1ola", ShorteningService.shorten("http://dir.bg/")
    travel_back
  end
end