module UnitTestActiveRecord
  module DisconnectActiveRecord
    def disconnect!
      (class << self; self; end).class_eval do
        def connection
          raise "ActiveRecord is disconnected; database access is unavailable in unit tests."
        end
      end
    end
  end
end
