class Visitor
  def accept(ast)
    ''
  end
end
class ActiveRecord::ConnectionAdapters::UnitRecordAdapter < ::ActiveRecord::ConnectionAdapters::AbstractAdapter
  EXCEPTION_MESSAGE = "ActiveRecord is disconnected; database access is unavailable in unit tests."

  def initialize(config = {})
    super
    @strategy = config[:strategy] || :raise
    @cached_columns = {"schema_info" => []}
  end
  
  def columns(table_name, name = nil)#:nodoc:
    @cached_columns[table_name.to_s] ||
      raise("Columns are not cached for '#{table_name}' - check schema.rb")
  end

  def create_table(table_name, options={})
    table_definition = ActiveRecord::ConnectionAdapters::TableDefinition.new(self)
    table_definition.primary_key(options[:primary_key] || "id") unless options[:id] == false
    yield table_definition
    @cached_columns[table_name.to_s] =
      table_definition.columns.map do |c|
        ActiveRecord::ConnectionAdapters::Column.new(c.name.to_s, c.default, c.sql_type, c.null)
      end
  end

  def primary_key(*args)
    'id'
  end
  
  def native_database_types
    # Copied from the MysqlAdapter so ColumnDefinition#sql_type will work
    {
      :primary_key => "int(11) DEFAULT NULL auto_increment PRIMARY KEY",
      :string      => { :name => "varchar", :limit => 255 },
      :text        => { :name => "text" },
      :integer     => { :name => "int", :limit => 11 },
      :float       => { :name => "float" },
      :decimal     => { :name => "decimal" },
      :datetime    => { :name => "datetime" },
      :timestamp   => { :name => "datetime" },
      :time        => { :name => "time" },
      :date        => { :name => "date" },
      :binary      => { :name => "blob" },
      :boolean     => { :name => "tinyint", :limit => 1 }
    }
  end
  
  def change_strategy(new_strategy, &block)
    unless [:noop, :raise].include?(new_strategy.to_sym)
      raise ArgumentError, "#{new_strategy.inspect} is not a valid strategy - valid values are :noop and :raise"
    end
    begin
      old_strategy = @strategy
      @strategy = new_strategy.to_sym
      yield
    ensure
      @strategy = old_strategy
    end
  end
  
  def execute(*args)
    raise_or_noop
  end
  
  def select_rows(*args)
    raise_or_noop []
  end
  
  def rename_table(*args)
    raise_or_noop
  end
  
  def change_column(*args)
    raise_or_noop
  end
  
  def change_column_default(*args)
    raise_or_noop
  end

  def rename_column(*args)
    raise_or_noop
  end

  def add_foreign_key(*args)
    raise_or_noop
  end

  def tables
    @cached_columns.keys
  end

  def visitor
    Visitor.new
  end

  def quote_column_name(column_name)
    column_name.to_s
  end

  protected
  
  def raise_or_noop(noop_return_value = nil)
    @strategy == :raise ? raise(EXCEPTION_MESSAGE) : noop_return_value
  end
  
  def select(*args)
    raise_or_noop []
  end
end
