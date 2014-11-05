require 'test_helper'

class WelcomeControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get tos" do
    get :tos
    assert_response :success
  end

  test "should get policy" do
    get :policy
    assert_response :success
  end

  test "should get about" do
    get :about
    assert_response :success
  end

end
