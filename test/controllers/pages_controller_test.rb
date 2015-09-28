require 'test_helper'

class PagesControllerTest < ActionController::TestCase

  #Test para el index
  test "should get index" do
    get :index
    assert_response :success
    assert_select "title", "Easycount"
  end

  #test "should get dashboard" do
  #  get :dashboard
  #  assert_response :success
  #end
end
