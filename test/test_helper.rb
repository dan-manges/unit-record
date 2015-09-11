unless defined?(TEST_HELPER_LOADED)
TEST_HELPER_LOADED = true
$:.unshift(File.dirname(__FILE__) + '/../lib')

require 'rubygems'
require 'rails/all'

module Rails
  class << self
    def root
      @root ||= Pathname.new(File.dirname(__FILE__))
    end
  end
end

if Rails::VERSION::MAJOR > 3 && Rails::VERSION::MINOR > 0
  if defined?(Bundler)
    # If you precompile assets before deploying to production, use this line
    Bundler.require(*Rails.groups(:assets => %w(development test)))
    # If you want your assets lazily compiled in production, use this line
    # Bundler.require(:default, :assets, Rails.env)
  end
end

require "action_controller/test_case" if Rails::VERSION::MAJOR == 2

$LOAD_PATH << File.dirname(__FILE__) + "/../vendor/dust-0.1.6/lib"
require 'dust'
Test::Unit::TestCase.disallow_setup!

$LOAD_PATH << File.dirname(__FILE__) + "/../lib"
require "unit_record"

if UnitRecord.rails_version >= "2.3"
  require "active_support/test_case"
  ActiveSupport::TestCase.class_eval { include ActiveRecord::TestFixtures }
end

UnitRecord.base_rails_test_class.use_transactional_fixtures = true

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
  self.table_name = 'foofoo'
end

class DoesNotExist < ActiveRecord::Base
  self.table_name = 'table_does_not_exist'
end

ActiveRecord::Base.disconnect! :strategy => :raise, :stub_associations => true
# make sure calling disconnect multiple times does not cause problems
ActiveRecord::Base.disconnect! :strategy => :raise, :stub_associations => true
end
