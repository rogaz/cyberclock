require 'test_helper'

class UtilsControllerTest < ActionController::TestCase
  test "should get manage_habtm" do
    get :manage_habtm
    assert_response :success
  end

end
