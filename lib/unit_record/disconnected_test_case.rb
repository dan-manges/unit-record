module UnitRecord
  module DisconnectedTestCase
    def disconnect!
      self.use_transactional_fixtures = false
    end
  end
end
