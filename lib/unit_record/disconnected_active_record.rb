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
      old_columns_file = File.join(RAILS_ROOT, 'db', 'columns.rb')
      File.delete old_columns_file if File.exists?(old_columns_file)
      ColumnCacher.cache(RAILS_ROOT + "/db/schema.rb")
    end
  end
end
