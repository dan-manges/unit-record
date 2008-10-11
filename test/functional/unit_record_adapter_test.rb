require File.dirname(__FILE__) + "/functional_test_helper"

functional_tests do
  test "execute raises an exception" do
    assert_raises_disconnected_exception do
      ActiveRecord::Base.connection.execute "SELECT 1"
    end
  end
  
  test "select_rows raises an exception" do
    assert_raises_disconnected_exception do
      ActiveRecord::Base.connection.select_rows "SELECT * FROM people"
    end
  end

  test "select raises an exception" do
    assert_raises_disconnected_exception do
      ActiveRecord::Base.connection.send :select, "SELECT * FROM people"
    end
  end
  
  test "rename_table raises an exception" do
    assert_raises_disconnected_exception do
      ActiveRecord::Base.connection.rename_table "people", "persons"
    end
  end

  test "change_column raises an exception" do
    assert_raises_disconnected_exception do
      ActiveRecord::Base.connection.change_column "people", "first_name", :string, :null => false
    end
  end

  test "change_column_default raises an exception" do
    assert_raises_disconnected_exception do
      ActiveRecord::Base.connection.change_column_default "people", "first_person", "george"
    end
  end

  test "rename_column raises an exception" do
    assert_raises_disconnected_exception do
      ActiveRecord::Base.connection.rename_column "people", "first_name", "name_first"
    end
  end

  def assert_raises_disconnected_exception(&block)
    exception = nil
    begin
      yield
    rescue Exception => exception
    end
    assert_not_nil exception
    assert_equal "ActiveRecord is disconnected; database access is unavailable in unit tests.", exception.message    
  end
end
