module UnitRecord
  module DisconnectedActiveRecord
    def disconnected?
      false
    end

    def disconnect!(options = {})
      return if disconnected?
      establish_connection options.merge(:adapter => "unit_record")
      if options[:stub_associations]
        ActiveRecord::Base.send :include, UnitRecord::AssociationStubbing
      end
      (class << self; self; end).class_eval do
        def disconnected?
          true
        end
      end
      Fixtures.disconnect!
      Test::Unit::TestCase.disconnect!
      ActiveRecord::Base.connection.change_strategy(:noop) do
        load(RAILS_ROOT + "/db/schema.rb")
      end
    end
  end
end
