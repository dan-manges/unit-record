module UnitTestActiveRecord
  module DisconnectedFixtures
    def disconnect!
      (class << self; self; end).class_eval do
        def create_fixtures(*args); end
      end
    end
  end
end
