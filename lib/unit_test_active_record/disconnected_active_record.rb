module UnitTestActiveRecord
  module DisconnectedActiveRecord
    def disconnect!
      columns_file = File.join(RAILS_ROOT, "db", "columns.rb")
      if File.exists?(columns_file)
        load columns_file
      else
        raise "Could not find columns.rb file to disconnect the database - run rake db:columns:dump"
      end
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
