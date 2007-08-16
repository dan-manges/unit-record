require File.dirname(__FILE__) + "/functional_test_helper"

functional_tests do
  test "use_transactional_fixtures is false" do
    assert_equal false, Test::Unit::TestCase.use_transactional_fixtures
  end
end
