require File.dirname(__FILE__) + "/../test_helper"

class ColumnDumperTest < Test::Unit::TestCase
  test "dumping columns" do
    stream = StringIO.new
    UnitRecord::ColumnDumper.dump(ActiveRecord::Base.connection, stream)
    expected = <<-END
Person.class_eval do
  def self.columns
    [
      ActiveRecord::ConnectionAdapters::Column.new("id", nil, "INTEGER", false),
      ActiveRecord::ConnectionAdapters::Column.new("first_name", nil, "varchar(255)", true),
      ActiveRecord::ConnectionAdapters::Column.new("last_name", nil, "varchar(255)", true),
    ]
  end
end
END
    assert_equal expected, stream.string
  end
end
