require File.dirname(__FILE__) + "/./disconnecting_test_helper"
# The '.' is intentional to have a TestCase require a different relative path.

class DisconnectedActiveRecordTest < Test::Unit::TestCase
  test "accessing connection raises" do
    assert_raises(RuntimeError) { ActiveRecord::Base.connection }
  end
  
  test "connected? is false" do
    assert_equal false, ActiveRecord::Base.connected?
  end
  
  test "disconnected? is true" do
    assert_equal true, ActiveRecord::Base.disconnected?
  end
end
