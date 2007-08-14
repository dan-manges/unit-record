require 'erb'
module UnitRecord
  class ColumnDumper
    private_class_method :new
    
    def self.dump(connection, stream)
      new(connection).write_to(stream)
    end
    
    def initialize(connection)
      @connection = connection
    end
    
    def columns_by_model
      @columns_by_model ||= tables.inject({}) do |hash,table|
        model = model_for_table(table)
        hash[model.to_s] = columns(table) if model
        hash
      end
    end
    
    def columns(table)
      @connection.columns(table)
    end
    
    def model_for_table(table)
      table.classify.constantize rescue nil
    end
    
    def tables
      @connection.tables
    end
    
    def write_to(stream)
      template = ERB.new <<-END, nil, '-'
<% columns_by_model.keys.sort.each do |model| -%>
<%= model %>.class_eval do
  def self.columns
    [
      <%- columns_by_model[model].each do |column| -%>
      ActiveRecord::ConnectionAdapters::Column.new(<%= column.name.to_s.inspect %>, <%= column.default.inspect %>, <%= column.sql_type.inspect %>, <%= column.null.inspect%>),
      <%- end -%>
    ]
  end
end
<%- end -%>
END
      text = template.result binding
      stream.write text
    end
  end
end
