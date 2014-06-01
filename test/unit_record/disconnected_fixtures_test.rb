require File.dirname(__FILE__) + "/../test_helper"

functional_tests do
  test "create_fixtures does nothing" do
    if defined?(Fixtures)
      assert_nothing_raised { Fixtures.create_fixtures }
    end
  end
end
