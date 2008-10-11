module UnitRecord
  module DisconnectedActiveRecord
    def disconnected?
      false
    end

    def disconnect!
      return if disconnected?
      establish_connection :adapter => "unit_record"
      (class << self; self; end).class_eval do
        def disconnected?
          true
        end
      end
      Fixtures.disconnect!
      Test::Unit::TestCase.disconnect!
      ActiveRecord::Base.connection.noop do
        load(RAILS_ROOT + "/db/schema.rb")
      end
    end
  end
end
