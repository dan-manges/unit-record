require 'rubygems'
require 'spec'

$LOAD_PATH.unshift(File.dirname(__FILE__) + '/../lib')

require 'rails/all'
module Rails
  class << self
    def root
      @root ||= Pathname.new(File.dirname(__FILE__))
    end
  end
end

puts "==== Testing with Rails #{Rails::VERSION::STRING} ===="

require 'unit_record'

if UnitRecord.rails_version >= '2.3'
  ActiveSupport::TestCase.class_eval { include ActiveRecord::TestFixtures }
end

# Needed because of this line in setup_with_fixtures and teardown_with_fixtures:
#   return unless defined?(ActiveRecord::Base) && !ActiveRecord::Base.configurations.blank?
ActiveRecord::Base.configurations = { 'irrelevant' => { adapter: 'stub' } }

ActiveRecord::Base.disconnect! strategy: :raise, stub_associations: true

describe UnitRecord do
  it 'disconnects tests from the database' do
    lambda do
      ActiveRecord::Base.connection.select_value('SELECT 1')
    end.should raise_error
  end

  it 'can change strategy to noop' do
    ActiveRecord::Base.connection.change_strategy(:noop) do
      ActiveRecord::Base.connection.select_value('SELECT 1').should.nil?
    end
  end
end
