$:.unshift(File.dirname(__FILE__) + '/../lib')
RAILS_ROOT = File.dirname(__FILE__)

require 'rubygems'
require 'test/unit'
require 'active_record'
require 'active_record/fixtures'
require 'active_support/binding_of_caller'
require 'active_support/breakpoint'
begin
  require 'mocha'
  require 'dust'
rescue LoadError
  raise "Need Mocha and Dust gems to Test"
end
Test::Unit::TestCase.disallow_setup!

require "#{File.dirname(__FILE__)}/../init"

Test::Unit::TestCase.use_transactional_fixtures = true

class Preference < ActiveRecord::Base
end
class Person < ActiveRecord::Base
end
