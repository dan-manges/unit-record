require File.dirname(__FILE__) + "/../test_helper"

unit_tests do
  test "dumping columns" do
    stream = StringIO.new
    UnitRecord::ColumnDumper.dump(ActiveRecord::Base.connection, stream)
    expected = <<-END
Person.class_eval do
  def self.columns
    [
      ActiveRecord::ConnectionAdapters::Column.new("id", nil, "int(11)", false),
      ActiveRecord::ConnectionAdapters::Column.new("first_name", nil, "varchar(255)", true),
      ActiveRecord::ConnectionAdapters::Column.new("last_name", nil, "varchar(255)", true),
    ]
  end
end
END
    assert stream.string.include?(expected)
  end
end
