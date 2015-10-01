require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest

  def setup
    User.delete_all
    attrs = attributes_for(:user)
    @user = User.new(attrs)
    @user.save
  end
  
  test "login with invalid information" do
    get root_path
    assert_template 'pages/index'
    post sessions_path, session: { email: "", password: "" }
    assert_not flash.empty?
    assert_includes flash.keys, :danger
    #get :back
    #assert_not_includes flash.keys, :danger
  end
  
  test "login with valid information" do
    get root_path
    post sessions_path, session: { email: @user.email, password: 'password' }
    assert_redirected_to dashboard_path, flash[:danger]
    follow_redirect!
    assert_template 'pages/dashboard'
    assert_select "a[href=?]", sessions_path, count: 0
    assert_select "a[href=?]", signout_path
    assert_select "a[href=?]", user_path(@user)
  end
end