module UnitRecord
  def self.rails_version
    Rails::VERSION::STRING
  end
  
  def self.base_rails_test_class
    if rails_version >= "2.3.1"
      ActiveSupport::TestCase
    else
      Test::Unit::TestCase
    end
  end
end
require "unit_record/association_stubbing"
require "unit_record/column_extension"
require "unit_record/disconnected_active_record"
require "unit_record/disconnected_test_case"
require "unit_record/disconnected_fixtures"
require "active_record/connection_adapters/unit_record_adapter"

require "active_record/fixtures"

ActiveRecord::ConnectionAdapters::Column.send :include, UnitRecord::ColumnExtension
ActiveRecord::Base.extend UnitRecord::DisconnectedActiveRecord
UnitRecord.base_rails_test_class.extend UnitRecord::DisconnectedTestCase
Fixtures.extend UnitRecord::DisconnectedFixtures

ActiveRecord::Base.class_eval do
  def self.unit_record_connection(config)
    ActiveRecord::ConnectionAdapters::UnitRecordAdapter.new(config)
  end
end
