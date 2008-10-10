require File.dirname(__FILE__) + "/functional_test_helper"

functional_tests do
  test "trying to execute a query raises" do
    assert_raises(RuntimeError) { ActiveRecord::Base.connection.execute "SELECT 1" }
  end
  
  test "find_by_sql gives disconnected exception message" do
    exception = nil
    begin
      Person.find_by_sql "SELECT * FROM people"
    rescue => exception
    end
    assert_not_nil exception
    assert_equal "ActiveRecord is disconnected; database access is unavailable in unit tests.", exception.message
  end
  
  test "connected? is true" do
    assert_equal true, ActiveRecord::Base.connected?
  end
  
  test "disconnected? is true" do
    assert_equal true, ActiveRecord::Base.disconnected?
  end
  
  test "inspect does not blow up" do
    assert_nothing_raised { Person.inspect }
  end
  
  test "table_exists?" do
    assert_equal true, Person.table_exists?
    if ActiveRecord::Base.connection.respond_to?(:table_exists?)
      assert_equal false, ActiveRecord::Base.connection.table_exists?("bogus_table")
    end
  end
  
  test "setting a has_one association" do
    person = Person.new
    person.profile = Profile.new
  end
  
  test "boolean columns do type casting" do
    pref = Preference.new
    pref.show_help = "0"
    assert_equal false, pref.send(:read_attribute, :show_help)
    assert_equal false, pref.show_help
    assert_equal false, pref.show_help?
    pref.show_help = "1"
    assert_equal true, pref.show_help
    assert_equal true, pref.show_help?
  end
end
