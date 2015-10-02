require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest

  def setup
    User.delete_all
    attrs = attributes_for(:user)
    @user = User.new(attrs)
    @user.save
  end

  test "application layout links" do
    get root_path
    assert_template 'pages/index'
  end
  
  test "dashboard layout links" do
    log_in_as(@user)
    get dashboard_path
    assert_template 'pages/dashboard'
    assert_select "a[href=?]", sessions_path, count: 0
    assert_select "a[href=?]", signout_path
    assert_select "a[href=?]", user_path(@user)
    assert_select "a[href=?]", edit_user_path(@user)
    assert_select "a[href=?]", change_password_path(@user)
  end
end
