require File.dirname(__FILE__) + "/functional_test_helper"

functional_tests do
  test "caching columns with no defaults or not nulls" do
    expected = [
      ActiveRecord::ConnectionAdapters::Column.new("id", nil, "int(11) DEFAULT NULL auto_increment PRIMARY KEY", nil),
      ActiveRecord::ConnectionAdapters::Column.new("first_name", nil, "varchar(255)", nil),
      ActiveRecord::ConnectionAdapters::Column.new("last_name", nil, "varchar(255)", nil)
    ]
    expected[0].primary = true
    expected[1..-1].each { |column| column.primary = false }
    assert_equal expected, Person.columns
  end
  
  test "caching column with default" do
    expected = ActiveRecord::ConnectionAdapters::Column.new("show_help", true, "tinyint(1)", nil)
    expected.primary = false
    assert_equal expected, Preference.columns.detect { |c| c.name == "show_help" }
  end
  
  test "boolean columns" do
    expected = ActiveRecord::ConnectionAdapters::Column.new("show_help", true, "tinyint(1)", nil)
    expected.primary = false
    assert_equal :boolean, Preference.columns.detect { |c| c.name == "show_help" }.type
  end
end
