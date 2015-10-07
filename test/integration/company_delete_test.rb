require 'test_helper'

class CompanyDeleteTest < ActionDispatch::IntegrationTest

  def setup
    User.delete_all
    attrs = attributes_for(:user)
    @user = User.new(attrs)
    @user.save

    @company = @user.companies.new(attributes_for(:company))
    @company.save
  end

  test "unsuccessful company delete" do

  end

  test "successful company delete" do

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
