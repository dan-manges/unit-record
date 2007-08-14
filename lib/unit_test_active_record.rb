require "unit_test_active_record/column_dumper"
require "unit_test_active_record/disconnected_active_record"
require "unit_test_active_record/disconnected_test_case"
require "unit_test_active_record/disconnected_fixtures"
ActiveRecord::Base.extend UnitTestActiveRecord::DisconnectedActiveRecord
Test::Unit::TestCase.extend UnitTestActiveRecord::DisconnectedTestCase
require "active_record/fixtures"
Fixtures.extend UnitTestActiveRecord::DisconnectedFixtures
