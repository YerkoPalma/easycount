require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  
  def setup
    User.delete_all
    attrs = attributes_for(:user)
    @user = User.new(attrs)
    @user.save
    
    attrs = attributes_for(:other)
    @other_user = User.new(attrs)
    @other_user.save
  end
  
  test "should redirect edit when not logged in" do
    get :edit, id: @user
    assert_not flash.empty?
    assert_redirected_to root_path
  end
  
  test "should redirect change_password when not logged in" do
    get :change_password, id: @user
    assert_not flash.empty?
    assert_redirected_to root_path
  end
  
  test "should redirect update when not logged in" do
    put :update, id: @user, user: { name: @user.name, email: @user.email }
    assert_not flash.empty?
    assert_redirected_to root_path
  end
  
  test "should redirect update_password when not logged in" do
    put :update_password, id: @user, user: { old_password: @user.password, password: "foobar", password_confirmation: "foobar" }
    assert_not flash.empty?
    assert_redirected_to root_path
  end
  
  test "should redirect edit when logged in as wrong user" do
    log_in_as(@other_user)
    get :edit, id: @user
    assert flash.empty?
    assert_redirected_to root_url
  end
  
  test "should redirect change_password when logged in as wrong user" do
    log_in_as(@other_user)
    get :change_password, id: @user
    assert flash.empty?
    assert_redirected_to root_url
  end
  
  test "should redirect update when logged in as wrong user" do
    log_in_as(@other_user)
    put :update, id: @user, user: { name: @user.name, email: @user.email }
    assert flash.empty?
    assert_redirected_to root_url
  end
  
  test "should redirect update_password when logged in as wrong user" do
    log_in_as(@other_user)
    put :update, id: @user, user: { old_password: @user.password, password: "foobar", password_confirmation: "foobar" }
    assert flash.empty?
    assert_redirected_to root_url
  end
end
