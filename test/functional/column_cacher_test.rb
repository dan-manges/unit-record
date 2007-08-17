require File.dirname(__FILE__) + "/functional_test_helper"

functional_tests do
  test "caching columns with no defaults or not nulls" do
    assert_equal [
      ActiveRecord::ConnectionAdapters::Column.new("id", nil, "int(11) DEFAULT NULL auto_increment PRIMARY KEY", nil),
      ActiveRecord::ConnectionAdapters::Column.new("first_name", nil, "varchar(255)", nil),
      ActiveRecord::ConnectionAdapters::Column.new("last_name", nil, "varchar(255)", nil)
    ], Person.columns
  end
  
  test "caching column with default" do
    assert_equal ActiveRecord::ConnectionAdapters::Column.new("show_help", true, "tinyint(1)", nil), Preference.columns.detect { |c| c.name == "show_help" }
  end
end
