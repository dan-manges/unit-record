require "rubygems"
gem "rspec", "1.1.11"
require "test/unit"
require "spec"

$:.unshift(File.dirname(__FILE__) + '/../lib')

RAILS_ROOT = File.dirname(__FILE__)

if rails_version = ENV['RAILS_VERSION']
  gem "rails", rails_version
end
require "rails/version"
puts "==== Testing with Rails #{Rails::VERSION::STRING} ===="
require 'active_record'
require 'active_record/fixtures'
require "action_controller"
require "action_controller/test_process"

require "unit_record"

# Needed because of this line in setup_with_fixtures and teardown_with_fixtures:
#   return unless defined?(ActiveRecord::Base) && !ActiveRecord::Base.configurations.blank?
ActiveRecord::Base.configurations = {"irrelevant" => {:adapter => "stub"}}

ActiveRecord::Base.disconnect! :strategy => :raise, :stub_associations => true

describe UnitRecord do
  it "disconnects tests from the database" do
    lambda do
      ActiveRecord::Base.connection.select_value("SELECT 1")
    end.should raise_error
  end

  it "can change strategy to noop" do
    ActiveRecord::Base.connection.change_strategy(:noop) do
      ActiveRecord::Base.connection.select_value("SELECT 1").should == nil
    end
  end
end
