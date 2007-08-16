module UnitRecord
  module ColumnExtension
    def ==(other)
      other && instance_variables.all? { |ivar| instance_variable_get(ivar) == other.instance_variable_get(ivar) }
    end
  end
end
