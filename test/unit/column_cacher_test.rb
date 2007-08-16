require File.dirname(__FILE__) + "/../test_helper"

class ColumnCacherTest < Test::Unit::TestCase
  test "caching columns with no defaults or not nulls" do
    UnitRecord::ColumnCacher.cache(RAILS_ROOT + "/db/schema.rb")
    assert_equal [
      ActiveRecord::ConnectionAdapters::Column.new("id", nil, :primary_key, nil),
      ActiveRecord::ConnectionAdapters::Column.new("first_name", nil, :string, nil),
      ActiveRecord::ConnectionAdapters::Column.new("last_name", nil, :string, nil)
    ], Person.columns
  end
  
  test "caching column with default" do
    
  end
end
