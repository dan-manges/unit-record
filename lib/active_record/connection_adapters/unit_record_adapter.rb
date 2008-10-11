class ActiveRecord::ConnectionAdapters::UnitRecordAdapter < ::ActiveRecord::ConnectionAdapters::AbstractAdapter
  EXCEPTION_MESSAGE = "ActiveRecord is disconnected; database access is unavailable in unit tests."

  def initialize(config = {})
    super
  end
  
  def columns(table_name, name = nil)#:nodoc:
    ActiveRecord::Base.cached_columns[table_name.to_s] ||
      raise("Columns are not cached for '#{table_name}' - check schema.rb")
  end

  def create_table(table_name, options={})
    table_definition = ActiveRecord::ConnectionAdapters::TableDefinition.new(self)
    table_definition.primary_key(options[:primary_key] || "id") unless options[:id] == false
    yield table_definition
    ActiveRecord::Base.cached_columns[table_name.to_s] =
      table_definition.columns.map do |c|
        ActiveRecord::ConnectionAdapters::Column.new(c.name.to_s, c.default, c.sql_type, c.null)
      end
  end
  
  def execute(sql, name = nil)
    raise EXCEPTION_MESSAGE
  end

  def select_rows(sql, name = nil)
    raise EXCEPTION_MESSAGE
  end
  
  def rename_table(table_name, new_name)
    raise EXCEPTION_MESSAGE
  end
  
  def change_column(table_name, column_name, type, options = {})
    raise EXCEPTION_MESSAGE
  end
  
  def change_column_default(table_name, column_name, default)
    raise EXCEPTION_MESSAGE
  end

  def rename_column(table_name, column_name, new_column_name)
    raise EXCEPTION_MESSAGE
  end
  
  def tables
    ActiveRecord::Base.cached_columns.keys
  end

  protected
  
  def select(sql, name = nil)
    raise EXCEPTION_MESSAGE
  end
end
