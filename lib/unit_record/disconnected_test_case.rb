module UnitRecord
  module DisconnectedTestCase
    def disconnect!
      self.use_transactional_fixtures = false if defined?(self.use_transactional_fixtures)

      class_eval do
        def self.fixtures(*args)
          raise "Fixtures cannot be used with UnitRecord. ActiveRecord is disconnected; database access is unavailable in unit tests."
        end
      end
    end
  end
end
