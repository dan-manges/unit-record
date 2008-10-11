require File.dirname(__FILE__) + "/../test_helper"

functional_tests do
  test "use_transactional_fixtures is false" do
    assert_equal false, Test::Unit::TestCase.use_transactional_fixtures
  end
  
  test "trying to use fixtures gives useful message" do
    exception = nil
    begin
      Class.new(Test::Unit::TestCase) do
        fixtures :users
      end
    rescue => exception
    end
    assert_not_nil exception
    assert_equal "Fixtures cannot be used with UnitRecord. ActiveRecord is disconnected; database access is unavailable in unit tests.", exception.message
  end
end
