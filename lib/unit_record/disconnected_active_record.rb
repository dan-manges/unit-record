module UnitRecord
  module DisconnectedActiveRecord
    def disconnected?
      connected? && connection.is_a?(ActiveRecord::ConnectionAdapters::UnitRecordAdapter)
    end

    def disconnect!(options = {})
      return if disconnected?
      establish_connection options.merge(:adapter => "unit_record")
      if options[:stub_associations]
        ActiveRecord::Base.send :include, UnitRecord::AssociationStubbing
      end
      Fixtures.disconnect!
      Test::Unit::TestCase.disconnect!
      ActiveRecord::Migration.verbose = false
      ActiveRecord::Base.connection.change_strategy(:noop) do
        load(RAILS_ROOT + "/db/schema.rb")
      end
    end
  end
end
