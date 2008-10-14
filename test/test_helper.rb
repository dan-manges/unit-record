unless defined?(TEST_HELPER_LOADED)
TEST_HELPER_LOADED = true
$:.unshift(File.dirname(__FILE__) + '/../lib')
RAILS_ROOT = File.dirname(__FILE__)

require 'rubygems'
require 'test/unit'

if rails_version = ENV['RAILS_VERSION']
  gem "rails", rails_version
end
require "rails/version"
puts "==== Testing with Rails #{Rails::VERSION::STRING} ===="
require 'active_record'
require 'active_record/fixtures'
require "action_controller"
if Rails::VERSION::MAJOR == 2
  require "action_controller/test_case"
end
require "action_controller/test_process"

begin
  gem "mocha"
  require 'mocha'
rescue LoadError, Gem::LoadError
  raise "need mocha to test"
end
$LOAD_PATH << File.dirname(__FILE__) + "/vendor/dust-0.1.6/lib"
require 'dust'
Test::Unit::TestCase.disallow_setup!

$LOAD_PATH << File.dirname(__FILE__) + "/../lib"
require "unit_record"

Test::Unit::TestCase.use_transactional_fixtures = true

# Needed because of this line in setup_with_fixtures and teardown_with_fixtures:
#   return unless defined?(ActiveRecord::Base) && !ActiveRecord::Base.configurations.blank?
ActiveRecord::Base.configurations = {"irrelevant" => {:adapter => "stub"}}

class Preference < ActiveRecord::Base
end

class Person < ActiveRecord::Base
  has_many :pets
  has_one :profile
end

class Profile < ActiveRecord::Base
  belongs_to :person
end

class Pet < ActiveRecord::Base
  belongs_to :person
end

class Foo < ActiveRecord::Base
  set_table_name :foofoo
end

class DoesNotExist < ActiveRecord::Base
  set_table_name "table_does_not_exist"
end

ActiveRecord::Base.disconnect! :strategy => :raise, :stub_associations => true
# make sure calling disconnect multiple times does not cause problems
ActiveRecord::Base.disconnect! :strategy => :raise, :stub_associations => true
end
