module UnitRecord
  module DisconnectedActiveRecord
    def disconnected?
      false
    end
    def disconnect!
      return if disconnected?
      (class << self; self; end).class_eval do
        def connection
          raise "ActiveRecord is disconnected; database access is unavailable in unit tests."
        end
        def connected?
          false
        end
        def disconnected?
          true
        end
      end
      Fixtures.disconnect!
      Test::Unit::TestCase.disconnect!
      ColumnCacher.cache(RAILS_ROOT + "/db/schema.rb")
    end
  end
end
