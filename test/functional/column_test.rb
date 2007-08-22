require File.dirname(__FILE__) + "/functional_test_helper"

functional_tests do
  test "instantiating" do
    person = Person.new :first_name => "Dan", :last_name => "Manges"
    assert_equal "Dan", person.first_name
    assert_equal "Manges", person.last_name
  end
  
  test "using model with column with a default" do
    record = Preference.new
    assert_equal true, record.show_help?
  end
  
  test "typecasting happens for integer attributes" do
    record = Preference.new
    record.some_count = "42"
    assert_equal 42, record.some_count
  end
  
  test "a model with a non-convential table name does not blow up" do
    assert_nothing_raised { Foo.columns }
  end
  
  test "using attribute on a model with a non-conventional table name" do
    foo = Foo.new
    foo.bar = "baz"
    assert_equal "baz", foo.bar
  end
  
  test "should get a descriptive error message if no cached columns" do
    exception = nil
    begin
      DoesNotExist.columns
    rescue => exception
    end
    assert_not_nil exception
    assert_equal "Columns are not cached for 'table_does_not_exist' - check schema.rb", exception.message
  end
end
