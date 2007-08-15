require File.dirname(__FILE__) + "/disconnecting_test_helper"

class DisconnectedTestCaseTest < Test::Unit::TestCase  
  test "use_transactional_fixtures is false" do
    assert_equal false, Test::Unit::TestCase.use_transactional_fixtures
  end
end
