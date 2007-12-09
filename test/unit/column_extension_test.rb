require File.dirname(__FILE__) + "/unit_test_helper"

unit_tests do
  test "equality" do
    column1 = ActiveRecord::ConnectionAdapters::Column.new("name", nil, :string, nil)
    column2 = ActiveRecord::ConnectionAdapters::Column.new("name", nil, :string, nil)
    assert_equal column1, column2
  end
  
  test "non-equality on name" do
    column1 = ActiveRecord::ConnectionAdapters::Column.new("name", nil, :string, nil)
    column2 = ActiveRecord::ConnectionAdapters::Column.new("different name", nil, :string, nil)
    assert column1 != column2
  end
  
  test "non-equality on sql_type" do
    column1 = ActiveRecord::ConnectionAdapters::Column.new("name", nil, :string, nil)
    column2 = ActiveRecord::ConnectionAdapters::Column.new("name", nil, :text, nil)
    assert column1 != column2
  end
  
  test "non-equality on default" do
    column1 = ActiveRecord::ConnectionAdapters::Column.new("name", nil, :string, nil)
    column2 = ActiveRecord::ConnectionAdapters::Column.new("name", "Dan", :string, nil)
    assert column1 != column2
  end
  
  test "non-equality on null" do
    column1 = ActiveRecord::ConnectionAdapters::Column.new("name", nil, :string, nil)
    column2 = ActiveRecord::ConnectionAdapters::Column.new("name", nil, :string, true)
    assert column1 != column2
  end
end
