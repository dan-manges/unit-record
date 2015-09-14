module UnitRecord
  module DisconnectedActiveRecord
    def disconnected?
      connected? && connection.is_a?(ActiveRecord::ConnectionAdapters::UnitRecordAdapter)
    end

    def disconnect!(options = {})
      return if disconnected?
      establish_connection options.merge(adapter: 'unit_record')
      if options[:stub_associations]
        ActiveRecord::Base.send :include, UnitRecord::AssociationStubbing
      end
      Fixtures.disconnect! if defined?(Fixtures)
      UnitRecord.base_rails_test_class.disconnect!
      ActiveRecord::Migration.verbose = false
      ActiveRecord::Base.connection.change_strategy(:noop) do
        load(Rails.root.join('db', 'schema.rb')) if defined?(Rails)
      end
    end
  end
end
