require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    #to prevent duplicate email
    User.delete_all
    @user = User.new(name: "Example", email: "user@example.com", password: "foobar", password_confirmation: "foobar")
  end

  test "should be valid" do
    assert @user.valid?, @user.errors.full_messages[0]
  end

  test "name should be present" do
    @user.name = "     "
    assert_not @user.valid?
  end

  test "name should not be too long" do
    @user.name = "a" * 51
    assert_not @user.valid?
  end

  test "email should be present" do
    @user.email = "     "
    assert_not @user.valid?
  end

  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  test "email addresses should be unique" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end

  test "password should be present" do
    @user.password = "   "
    @user.password_confirmation = ""
    assert_not @user.valid?
  end

  test "password should be equal" do
    @user.password = "foobar1"
    @user.password_confirmation = "foobar"
    assert_not @user.valid?
  end

  test "password should be more than 6 characters long" do
    @user.password = "12345"
    assert_not @user.valid?
  end

end
