require File.dirname(__FILE__) + '/functional_test_helper'

class SampleController < ActionController::Base
  def sample_action
    render :text => "OK"
  end
end

ActionController::Routing::Routes.add_route "/sample/sample_action", :controller => "sample", :action => "sample_action"

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
