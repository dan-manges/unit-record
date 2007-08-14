require File.dirname(__FILE__) + "/disconnecting_test_helper"

class DisconnectedActiveRecordTest < Test::Unit::TestCase
  def test_accessing_connection_raises
    assert_raises(RuntimeError) { ActiveRecord::Base.connection }
  end
  
  def test_connected_is_false
    assert_equal false, ActiveRecord::Base.connected?
  end
  
  def test_raises_meaningful_exception_if_columns_rb_does_not_exist
    File.stubs(:exists?).returns(false)
    begin
      ActiveRecord::Base.disconnect!
    rescue => ex
    end
    assert_equal "Could not find columns.rb file to disconnect the database - run rake db:columns:dump", ex.message
  end
end
