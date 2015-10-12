require File.dirname(__FILE__) + '/../test_helper'

class SampleApplication < Rails::Application
end
SampleApplication.routes.draw do
  match '/sample/sample_action', to: 'sample#sample_action'
end

SampleApplication.routes.draw do
  match '/sample/sample_action', to: 'sample#sample_action'
end
class SampleController < ActionController::Base
  include SampleApplication.routes.url_helpers
  def sample_action
    render text: 'OK'
  end
end

class ControllerTest < ActionController::TestCase
  tests SampleController

  test 'render' do
    @routes = SampleApplication.routes
    get :sample_action
    assert_equal 'OK', @response.body
  end
end
