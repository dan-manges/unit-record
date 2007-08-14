require File.dirname(__FILE__) + "/disconnecting_test_helper"

class DisconnectedActiveRecordTest < Test::Unit::TestCase
  def test_accessing_connection_raises
    assert_raises(RuntimeError) { ActiveRecord::Base.connection }
  end
  
  def test_connected_is_false
    assert_equal false, ActiveRecord::Base.connected?
  end
end
