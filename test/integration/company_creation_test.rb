require 'test_helper'

class CompanyCreationTest < ActionDispatch::IntegrationTest

  def setup
    User.delete_all
    attrs = attributes_for(:user)
    @user = User.new(attrs)
    @user.save
  end

  test "invalid company creation" do
    log_in_as(@user)
    get new_user_company_path(@user)
    assert_template "companies/new"
    assert_no_difference "@user.companies.count" do
      post user_companies_path(@user), company: {rut: "",
                                               name: "Invalid Company",
                                               description: "",
                                               avatar: "",
                                               selected: false}
    end
    assert_template "companies/new"
    assert_not flash.empty?
    assert_includes flash.keys, :danger
  end

  test "valid company creation" do
    log_in_as(@user)
    get new_user_company_path(@user)
    assert_template "companies/new"
    assert_difference "@user.companies.count", 1, @user.errors.full_messages[0] do
      post_via_redirect user_companies_path(@user), company: {rut: "723456789",
                                               name: "Acme",
                                               description: ""}
    end

    assert_template "users/show"
    assert_not_includes flash.keys, :danger
  end
end
