require File.dirname(__FILE__) + "/../../test_helper"

functional_tests do

  test "find(:all)" do
    ActiveRecord::Base.connection.change_strategy(:raise) do
      assert_raises(RuntimeError) { Person.find(:all) }
    end
    ActiveRecord::Base.connection.change_strategy(:noop) do
      assert_equal [], Person.find(:all)
    end
  end
  
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
  
  test "initialize can set strategy" do
    ActiveRecord::Base.establish_connection :adapter => "unit_record", :strategy => :noop
    assert_nil ActiveRecord::Base.connection.execute("SELECT 1")
    ActiveRecord::Base.establish_connection :adapter => "unit_record", :strategy => :raise
    assert_raises(RuntimeError) { ActiveRecord::Base.connection.execute("SELECT 1") }
  end

  test "noop" do
    ActiveRecord::Base.connection.change_strategy(:noop) do
      assert_nil ActiveRecord::Base.connection.execute("SELECT 1")
      assert_equal [], ActiveRecord::Base.connection.select_rows("SELECT * FROM people")
      assert_equal [], ActiveRecord::Base.connection.send(:select, "SELECT * FROM people")
      assert_nil ActiveRecord::Base.connection.rename_table("people", "persons")
      assert_nil ActiveRecord::Base.connection.change_column("people", "first_name", :string, :null => false)
      assert_nil ActiveRecord::Base.connection.change_column_default("people", "first_person", "george")
      assert_nil ActiveRecord::Base.connection.rename_column("people", "first_name", "name_first")
    end
  end
  
  test "change_strategy raises if invalid strategy" do
    assert_nothing_raised { ActiveRecord::Base.connection.change_strategy(:noop) {} }
    assert_nothing_raised { ActiveRecord::Base.connection.change_strategy(:raise) {} }
    assert_raises(ArgumentError) { ActiveRecord::Base.connection.change_strategy(:bogus) {} }
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
