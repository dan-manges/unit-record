require File.dirname(__FILE__) + "/functional_test_helper"

functional_tests do
  test "create_fixtures does nothing" do
    assert_nothing_raised { Fixtures.create_fixtures }
  end
end
