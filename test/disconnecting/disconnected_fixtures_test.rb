require File.dirname(__FILE__) + "/disconnecting_test_helper"

class DisconnectedTestCaseTest < Test::Unit::TestCase  
  test "create_fixtures does nothing" do
    assert_nothing_raised { Fixtures.create_fixtures }
  end
end
