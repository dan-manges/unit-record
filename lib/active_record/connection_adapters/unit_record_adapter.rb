class ActiveRecord::ConnectionAdapters::UnitRecordAdapter < ::ActiveRecord::ConnectionAdapters::AbstractAdapter
  def initialize(config = {})
    super
  end
  
  def columns(table_name, name = nil)#:nodoc:
    ActiveRecord::Base.cached_columns[table_name.to_s] ||
      raise("Columns are not cached for '#{table_name}' - check schema.rb")
  end
  
  def execute(sql, name = nil)
    raise "ActiveRecord is disconnected; database access is unavailable in unit tests."
  end

  def select(sql, name = nil)
    raise "ActiveRecord is disconnected; database access is unavailable in unit tests."
  end
  
  def tables
    ActiveRecord::Base.cached_columns.keys
  end
end
