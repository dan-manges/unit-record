require File.dirname(__FILE__) + "/functional_test_helper"

functional_tests do
  test "accessing connection raises" do
    assert_raises(RuntimeError) { ActiveRecord::Base.connection }
  end
  
  test "accessing connection gives exception message with class name" do
    exception = nil
    begin
      Person.connection
    rescue => exception
    end
    assert_not_nil exception
    assert_equal "(from Person): ActiveRecord is disconnected; database access is unavailable in unit tests.", exception.message
  end
  
  test "connected? is false" do
    assert_equal false, ActiveRecord::Base.connected?
  end
  
  test "disconnected? is true" do
    assert_equal true, ActiveRecord::Base.disconnected?
  end
  
  test "inspect does not blow up" do
    assert_nothing_raised { Person.inspect }
  end
  
  test "table_exists?" do
    assert_equal true, Person.table_exists?
  end
end
