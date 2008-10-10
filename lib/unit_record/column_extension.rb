module UnitRecord
  module ColumnExtension
    def self.included(base)
      base.class_eval do
        alias_method_chain :simplified_type, :boolean
      end
    end
    
    def simplified_type_with_boolean(field_type)
      return :boolean if field_type.to_s.downcase.index("tinyint(1)")
      simplified_type_without_boolean field_type
    end

    def ==(other)
      other && instance_variables.all? { |ivar| instance_variable_get(ivar) == other.instance_variable_get(ivar) }
    end
  end
end
