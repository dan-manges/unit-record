require File.dirname(__FILE__) + "/functional_test_helper"

functional_tests do
  test "instantiating" do
    person = Person.new :first_name => "Dan", :last_name => "Manges"
    assert_equal "Dan", person.first_name
    assert_equal "Manges", person.last_name
  end
  
  test "using model with column with a default" do
    
  end
end
