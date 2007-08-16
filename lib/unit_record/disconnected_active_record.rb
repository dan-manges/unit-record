module UnitRecord
  module DisconnectedActiveRecord
    def disconnected?
      false
    end
    def disconnect!
      return if disconnected?
      ColumnCacher.cache(RAILS_ROOT + "/db/schema.rb")
      # columns_file = File.join(RAILS_ROOT, "db", "columns.rb")
      # File.open(columns_file, "w") do |file|
      #   UnitRecord::ColumnDumper.dump(ActiveRecord::Base.connection, file)
      # end
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
      # load columns_file
      Fixtures.disconnect!
      Test::Unit::TestCase.disconnect!
    end
  end
end
