require File.dirname(__FILE__) + '/../test_helper'

class SampleController < ActionController::Base
  def sample_action
    render :text => "OK"
  end
end

ActionController::Routing::Routes.add_route "/sample/sample_action", :controller => "sample", :action => "sample_action"

if defined?(ActionController::TestCase) # Rails 2

  class ControllerTest < ActionController::TestCase
    tests SampleController
  
    test "render" do
      get :sample_action
      assert_equal "OK", @response.body
    end
  
    test "sql caching is enabled" do
      assert_equal true, (SampleController < ActionController::Caching::SqlCache)
    end
  end

else # Rails 1.x

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

end
