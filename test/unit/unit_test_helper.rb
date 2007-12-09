require File.dirname(__FILE__) + "/../test_helper"

ActiveRecord::Base.establish_connection \
  :adapter => "mysql",
  :database => "stub_development"
