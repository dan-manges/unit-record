require File.dirname(__FILE__) + "/../test_helper"

unit_tests do
  if UnitRecord.rails_version > "2.3"
    test "test case base class" do
      assert_equal ActiveSupport::TestCase, UnitRecord.base_rails_test_class
    end
  else
    test "test case base class" do
      assert_equal Test::Unit::TestCase, UnitRecord.base_rails_test_class
    end
  end

end