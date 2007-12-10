$:.unshift(File.dirname(__FILE__) + '/../lib')
RAILS_ROOT = File.dirname(__FILE__)

require 'rubygems'
require 'test/unit'

if version = ENV['RAILS_VERSION']
  gem "rails", version
end
require 'active_record'
require 'active_record/fixtures'
require "action_controller"
require "action_controller/test_case"
require "action_controller/test_process"

begin
  require 'mocha'
  require 'dust'
rescue LoadError
  raise "Need Mocha and Dust gems to Test"
end
Test::Unit::TestCase.disallow_setup!

require "#{File.dirname(__FILE__)}/../init"

Test::Unit::TestCase.use_transactional_fixtures = true

# Needed because of this line in setup_with_fixtures and teardown_with_fixtures:
#   return unless defined?(ActiveRecord::Base) && !ActiveRecord::Base.configurations.blank?
ActiveRecord::Base.configurations = {"irrelevant" => {:adapter => "stub"}}

class Preference < ActiveRecord::Base
end
class Person < ActiveRecord::Base
end
class Foo < ActiveRecord::Base
  set_table_name :foofoo
end
class DoesNotExist < ActiveRecord::Base
  set_table_name "table_does_not_exist"
end
