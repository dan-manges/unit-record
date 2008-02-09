require "unit_record/association_stubbing"
require "unit_record/column_cacher"
require "unit_record/column_extension"
require "unit_record/disconnected_active_record"
require "unit_record/disconnected_test_case"
require "unit_record/disconnected_fixtures"

require "active_record/fixtures"

ActiveRecord::ConnectionAdapters::Column.send :include, UnitRecord::ColumnExtension
ActiveRecord::Base.extend UnitRecord::DisconnectedActiveRecord
Test::Unit::TestCase.extend UnitRecord::DisconnectedTestCase
Fixtures.extend UnitRecord::DisconnectedFixtures
