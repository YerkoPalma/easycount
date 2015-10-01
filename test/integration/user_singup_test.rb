require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

  def setup
    User.delete_all
  end
  
  test "invalid signup information" do
    get root_path
    assert_no_difference 'User.count' do
      post users_path, user: { name:  "",
                               email: "user@invalid",
                               password:              "foo",
                               password_confirmation: "bar" }
    end
    assert_template 'pages/index'
    assert_includes flash.keys, :error
  end
  
  test "valid signup information" do
    get root_path
    assert_difference 'User.count', 1 do
      post_via_redirect users_path, user: attributes_for(:user)
    end
    assert_template 'pages/dashboard'
    assert_not_includes flash.keys, :error
    @user = User.find(build(:user).name)
    assert is_logged_in?(@user) , "c: #{cookies[:remember_token]}\nu: #{@user.remember_token}"
  end
end