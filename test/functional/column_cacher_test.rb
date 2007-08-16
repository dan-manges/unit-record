require File.dirname(__FILE__) + "/functional_test_helper"

functional_tests do
  test "caching columns with no defaults or not nulls" do
    assert_equal [
      ActiveRecord::ConnectionAdapters::Column.new("id", nil, :primary_key, nil),
      ActiveRecord::ConnectionAdapters::Column.new("first_name", nil, :string, nil),
      ActiveRecord::ConnectionAdapters::Column.new("last_name", nil, :string, nil)
    ], Person.columns
  end
  
  test "caching column with default" do
    assert_equal [ActiveRecord::ConnectionAdapters::Column.new("show_help", false, :boolean, nil)], Preference.columns[1..-1]
  end
end
