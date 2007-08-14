require File.dirname(__FILE__) + "/disconnecting_test_helper"

class DisconnectedTestCaseTest < Test::Unit::TestCase  
  def test_create_fixtures_does_nothing
    assert_nothing_raised { Fixtures.create_fixtures }
  end
end
