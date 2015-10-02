require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest

  def setup
    User.delete_all
    attrs = attributes_for(:user)
    @user = User.new(attrs)
    @user.save
  end

  test "unsuccessful edit" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    put user_path(@user), user: { name:  "",
                                    email: "foo@invalid" }
    assert_template 'users/edit'
    assert_not flash.empty?
    assert_includes flash.keys, :danger
  end
  
  test "unsuccessful password edit due to wrong actual password" do
    log_in_as(@user)
    get change_password_path(@user)
    assert_template 'users/change_password'
    put update_password_path(@user), user: { old_password: "other_pass",
                                  password:  "foobar",
                                  password_confirmation: "foobar" }
    assert_template 'users/change_password'
    assert_not flash.empty?
    assert_includes flash.keys, :danger
  end
  
  test "unsuccessful password edit due to wrong password_confirmation" do
    log_in_as(@user)
    get change_password_path(@user)
    assert_template 'users/change_password'
    put update_password_path(@user), user: { old_password: "password",
                                  password:  "foobarrrr",
                                  password_confirmation: "foobar" }
    assert_template 'users/change_password'
    assert_not flash.empty?
    assert_includes flash.keys, :danger
  end
  
  test "successful edit" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    name  = "Foo Bar"
    email = "foo@bar.com"
    put user_path(@user), user: { name:  name,
                                    email: email }
    #assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal name,  @user.name
    assert_equal email, @user.email
  end
  
  test "successful password edit" do
    log_in_as(@user)
    get change_password_path(@user)
    assert_template 'users/change_password'
    pass  = "password"
    newPass = "foobar"
    put update_password_path(@user), user: { old_password: pass,
                                  password:  newPass,
                                  password_confirmation: newPass }
    #assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert @user.authenticate(newPass)
  end
  
  test "successful edit with friendly forwarding" do
    get edit_user_path(@user)
    log_in_as(@user)
    assert_redirected_to edit_user_path(@user)
    name  = "Foo Bar"
    email = "foo@bar.com"
    patch user_path(@user), user: { name:  name,
                                    email: email,
                                    password:              "",
                                    password_confirmation: "" }
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal name,  @user.name
    assert_equal email, @user.email
  end
  
  test "successful password edit with friendly forwarding" do
    get change_password_path(@user)
    log_in_as(@user)
    assert_redirected_to change_password_path(@user)
    pass  = "password"
    newPass = "foobar"
    put update_password_path(@user), user: { old_password: pass,
                                  password:  newPass,
                                  password_confirmation: newPass }
    #assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert @user.authenticate(newPass)
  end
end