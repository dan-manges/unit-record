module UnitTestActiveRecord
  module DisconnectedActiveRecord
    def disconnect!
      (class << self; self; end).class_eval do
        def connection
          raise "ActiveRecord is disconnected; database access is unavailable in unit tests."
        end
        def connected?
          false
        end
      end
      Fixtures.disconnect!
      Test::Unit::TestCase.disconnect!
    end
  end
end
