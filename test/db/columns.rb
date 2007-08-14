Person.class_eval do
  def self.columns
    [
      ActiveRecord::ConnectionAdapters::Column.new("id", nil, "INTEGER", false),
      ActiveRecord::ConnectionAdapters::Column.new("first_name", nil, "varchar(255)", true),
      ActiveRecord::ConnectionAdapters::Column.new("last_name", nil, "varchar(255)", true),
    ]
  end
end
