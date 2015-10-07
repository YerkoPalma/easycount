require 'test_helper'

class CompaniesControllerTest < ActionController::TestCase

  def setup
    User.delete_all
    attrs = attributes_for(:user)
    @user = User.new(attrs)
    @user.save

    attrs = attributes_for(:other)
    @other_user = User.new(attrs)
    @other_user.save

    @company = @user.companies.new(attributes_for(:company))
    @company.save
  end

  test "should redirect to user profile whene editing other company" do
    log_in_as @user
    get :edit, user_id: @other_user.id, id: @company.id
    assert_not flash.empty?
    assert_redirected_to @user
  end

  test "should redirect to user profile whene deleting other company" do
    log_in_as @user    
    delete :destroy, user_id: @other_user.id, id: @company.id
    assert_not flash.empty?
    assert_redirected_to @user
  end

  test "should not allow to select other companies" do
    log_in_as @user
    post :select, user_id: @other_user.id, company_id: @company.id
    assert_not flash.empty?
    assert_redirected_to @user
  end

end
