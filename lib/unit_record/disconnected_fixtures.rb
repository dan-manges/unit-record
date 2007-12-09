module UnitRecord
  module DisconnectedFixtures
    def disconnect!
      (class << self; self; end).class_eval do
        def create_fixtures(*args); end
        def reset_cache; end
      end
    end
  end
end
