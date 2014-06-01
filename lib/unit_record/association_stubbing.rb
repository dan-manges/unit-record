module UnitRecord
  module AssociationStubbing
    
    private
    
    def initialize_with_association_stubbing(attributes = {})
      associations = extract_associations attributes
      initialize_without_association_stubbing attributes
      stub_associations associations
    end
    
    protected
  
    def extract_associations(attributes = {})
      attributes.inject({}) do |associations,(attr,value)|
        next associations unless self.class.reflections.keys.include? attr
        unless value.is_a?(self.class.reflections[attr].klass)
          associations[attr] = attributes.delete attr
        end
        associations
      end
    end
  
    def stub_associations(associations = {})
      associations.each do |attr,value|
        self.stubs(attr).returns(value)
      end
    end

    def self.included(klass)
      klass.class_eval do
        unless (instance_methods + private_instance_methods).include?("initialize_without_association_stubbing")
          alias_method_chain :initialize, :association_stubbing
        end
      end
    end
  end
end
