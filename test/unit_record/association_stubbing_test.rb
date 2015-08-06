require File.dirname(__FILE__) + "/../test_helper"

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

  test "using correct classes does not stub" do
    person = Person.new(:first_name => "Dan")
    pet = Pet.new :person => person
    pet.person = Person.new(:first_name => "Tom")
    assert_equal "Tom", pet.person.first_name
  end

  test "using other than correct classes does stub" do
    person = Object.new
    def person.first_name; "Dan"; end
    pet = Pet.new :person => person
    pet.person = Person.new(:first_name => "Tom")
    assert_equal "Dan", pet.person.first_name
  end

  test "multiple includes does not hurt" do
    ActiveRecord::Base.send :include, UnitRecord::AssociationStubbing
    Person.new
  end

end
