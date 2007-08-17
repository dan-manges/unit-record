module UnitRecord
  class ColumnCacher
    include ActiveRecord::ConnectionAdapters::SchemaStatements

    def self.cache(file)
      (class << ActiveRecord::Schema; self; end).class_eval do
        def define(options={}, &block)
          UnitRecord::ColumnCacher.new.instance_eval(&block)
        end
      end
      load file
    end

    def create_table(table_name, options={})
      table_definition = ActiveRecord::ConnectionAdapters::TableDefinition.new(self)
      table_definition.primary_key(options[:primary_key] || "id") unless options[:id] == false
      yield table_definition
      if model = model_for_table(table_name)
        (class << model; self; end).class_eval do
          define_method(:columns) do
            table_definition.columns.map do |c|
              ActiveRecord::ConnectionAdapters::Column.new(c.name.to_s, c.default, c.sql_type, c.null)
            end
          end
        end
      end
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

    def model_for_table(table)
      table.to_s.classify.constantize rescue nil
    end
  end
end
