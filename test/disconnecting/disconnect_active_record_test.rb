require File.dirname(__FILE__) + "/../test_helper"

class ActiveRecordBaseTest < Test::Unit::TestCase
  def setup
    ActiveRecord::Base.disconnect!
  end
  
  def test_accessing_connection_raises
    assert_raises(RuntimeError) { ActiveRecord::Base.connection }
  end
end
