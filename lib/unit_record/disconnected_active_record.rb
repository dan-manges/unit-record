module UnitRecord
  module DisconnectedActiveRecord
    def disconnect!
      columns_file = File.join(RAILS_ROOT, "db", "columns.rb")
      File.open(columns_file, "w") do |file|
        UnitRecord::ColumnDumper.dump(ActiveRecord::Base.connection, file)
      end
      load columns_file
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
