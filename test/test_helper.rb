$:.unshift(File.dirname(__FILE__) + '/../lib')
RAILS_ROOT = File.dirname(__FILE__)

require 'rubygems'
require 'test/unit'
require 'active_record'
require 'active_record/fixtures'
require 'active_support/binding_of_caller'
require 'active_support/breakpoint'

ActiveRecord::Base.configurations['test'] = YAML::load(IO.read(File.dirname(__FILE__) + '/database.yml'))
ActiveRecord::Base.logger = Logger.new(File.dirname(__FILE__) + "/debug.log")
ActiveRecord::Base.establish_connection(ActiveRecord::Base.configurations['test'][ENV['DB'] || 'sqlite3'])

require "#{File.dirname(__FILE__)}/../init"
silence_stream(STDOUT) do
  load(File.dirname(__FILE__) + "/schema.rb") if File.exist?(File.dirname(__FILE__) + "/schema.rb")
end

class Person < ActiveRecord::Base
end
