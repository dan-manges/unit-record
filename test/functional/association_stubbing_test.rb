require File.dirname(__FILE__) + "/functional_test_helper"

functional_tests do
  
  test "stubbing a has_many" do
    pets = [stub, stub]
    person = Person.new :pets => pets
    assert_equal pets, person.pets
  end
  
  test "stubbing a belongs_to" do
    person = stub
    pet = Pet.new :person => person
    assert_equal person, pet.person
  end
  
  test "multiple includes doesn't hurt" do
    ActiveRecord::Base.send :include, UnitRecord::AssociationStubbing
    Person.new
  end
  
end
