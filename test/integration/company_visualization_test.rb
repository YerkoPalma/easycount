require 'test_helper'

class CompanyVisualizationTest < ActionDispatch::IntegrationTest

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

  test "unsuccessful company visualization" do
    get user_company_path(@user, @company)
    assert_redirected_to root_url
    assert_not flash.empty?, "flash is empty"
    assert_includes flash.keys, :danger, flash[:notice]
    log_in_as @user
    assert_redirected_to user_company_path(@user, @company)
    follow_redirect!
    assert_template "companies/show"
  end

  test "successful company visualization" do
    log_in_as @user
    get user_company_path(@user, @company)
    assert_template "companies/show"
    assert flash.empty?, flash.keys
  end

  test "should always have a selected company if any" do
    log_in_as @user
    get user_companies_path(@user)
    assert_template "companies/index"
    assert_select "a[data-tooltip=?]", "Empresa seleccionada", count: 1
  end

  test "successful company selection" do
    log_in_as @user
    @other_company = @user.companies.new(attributes_for(:other_company))
    @other_company.save
    get user_companies_path(@user)
    assert_select "a[href=?]", select_company_path(@user, @other_company), count: 1
    post select_company_path(@user, @other_company)
    assert_select "a[href=?]", select_company_path(@user, @other_company), count: 0
    assert_select "a[href=?]", select_company_path(@user, @company), count: 1
  end

  test "successful companies visualization" do
    log_in_as @user
    get user_companies_path(@user, @company)
    assert_template "companies/index"
  end

  test "should show default avatar image if no one suplied" do
    log_in_as @user
    @other_company = @user.companies.new(attributes_for(:other_company))

    @other_company.save
    get user_companies_path(@user)
    post select_company_path(@user, @other_company)
    assert_select "img[alt=?]", "Default"
  end
end
