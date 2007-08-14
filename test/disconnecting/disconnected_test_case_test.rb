require File.dirname(__FILE__) + "/disconnecting_test_helper"

class DisconnectedTestCaseTest < Test::Unit::TestCase  
  def test_transactional_fixtures_is_false
    assert_equal false, Test::Unit::TestCase.use_transactional_fixtures
  end
end
