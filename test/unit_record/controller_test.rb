require File.dirname(__FILE__) + '/../test_helper'

class SampleController < ActionController::Base
  def sample_action
    render :text => "OK"
  end
end

case Rails::VERSION::MAJOR
when 1, 2
  ActionController::Routing::Routes.add_route "/sample/sample_action", :controller => "sample", :action => "sample_action"
when 3
end

if Rails::VERSION::MAJOR == 3
  # todo
elsif Rails::VERSION::MAJOR == 2

  class ControllerTest < ActionController::TestCase
    tests SampleController

    test "render" do
      get :sample_action
      assert_equal "OK", @response.body
    end

    if defined?(ActionController::Caching::SqlCache) # SqlCache goes away in Rails 2.3.1
      test "sql caching is enabled" do
        assert_equal true, (SampleController < ActionController::Caching::SqlCache)
      end
    end
  end

elsif Rails::VERSION::MAJOR == 1

  class ControllerTest < Test::Unit::TestCase
    def setup
      @controller = SampleController.new
      @request    = ActionController::TestRequest.new
      @response   = ActionController::TestResponse.new
    end

    test "render" do
      get :sample_action
      assert_equal "OK", @response.body
    end
  end
else
  raise "rails version not tested"
end
