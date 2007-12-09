module UnitRecord
  module DisconnectedActiveRecord
    def disconnected?
      false
    end
    def disconnect!
      return if disconnected?
      (class << self; self; end).class_eval do
        def cached_columns
          @@_cached_columns ||= {}
        end
        def columns
          cached_columns[table_name] ||
           raise("Columns are not cached for '#{table_name}' - check schema.rb")
        end
        def connection
          raise "(from #{to_s}): ActiveRecord is disconnected; database access is unavailable in unit tests."
        end
        def connected?
          false
        end
        def disconnected?
          true
        end
        def table_exists?
          true
        end
      end
      Fixtures.disconnect!
      Test::Unit::TestCase.disconnect!
      ColumnCacher.cache(RAILS_ROOT + "/db/schema.rb")
    end
  end
end
