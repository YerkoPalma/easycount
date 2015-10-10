require 'test_helper'

class CompanyDeleteTest < ActionDispatch::IntegrationTest

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

  test "unsuccessful company delete" do
    #session.delete(:return_to) if !session[:return_to].nil?
    #puts session
    log_in_as(@other_user, {:password => "foobar"})
    get_via_redirect user_companies_path(@other_user)
    #assert_template "companies/index" , user_companies_path(@other_user)
    #assert_not_select "a[href=?]", destroy_company_path(@user, @company)
    assert_no_difference '@user.companies.count' do
      delete destroy_company_path(@user, @company)
    end

  end

  test "successful company delete" do
    skip "something is missing!"
    log_in_as(@user)
    get user_companies_path(@user)
    assert_template "companies/index"
    assert_select "a[href=?]", destroy_company_path(@user, @company)
    assert_difference '@user.companies.count', -1 do
      delete destroy_company_path(@user, @company)
    end
    #delete destroy_company_path(@user, @company)
    assert_template "companies/index"
    assert_not flash.empty?
    assert_includes flash.keys, :success
  end

  test "unsuccessful company edit" do
    log_in_as(@user)
    get edit_user_company_path(@user, @company)
    assert_template 'companies/edit'
    put user_company_path(@user, @company), company: {rut: "12345678",
                                                      name: "",
                                                      description: "invalid company"}
    assert_template 'companies/edit'
    assert_not flash.empty?
    assert_includes flash.keys, :danger
  end

  test "successful company edit" do
    log_in_as(@user)
    get edit_user_company_path(@user, @company)
    assert_template 'companies/edit'
    put user_company_path(@user, @company), company: {rut: "723456789",
                                                      name: "NewCompanyName",
                                                      description: "invalid company"}
    assert_redirected_to user_company_path(@user, @company)
    #assert_template 'companies/show'
    #assert_not flash.empty?
    assert_not_includes flash.keys, :danger
  end


end
