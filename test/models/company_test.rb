require 'test_helper'

class CompanyTest < ActiveSupport::TestCase

  def setup
    User.delete_all
    attrs = attributes_for(:user)
    @user = User.new(attrs)
    @user.save

    @company = @user.companies.new(attributes_for(:company))
  end

  test "should be valid" do    
    assert @user.valid?, @user.errors.full_messages[0]
    assert @company.valid?, @company.errors.full_messages[0]
  end

  test "contador should be present" do
    @company.contador = nil
    assert_not @company.valid?
  end

  test "name should be present" do
    @company.name = "     "
    assert_not @company.valid?
  end
  test "rut should be present" do
    @company.rut = "     "
    assert_not @company.valid?
  end
  test "rut should be unique" do
    duplicate_company = @company.dup
    @company.save
    assert_not duplicate_company.valid?
  end
  test "rut should be more than 72000000" do
    @company.rut = "719999991"
    assert_not @company.valid?
  end

  test "rut dv should be valid" do
    @company.rut = "767506509"
    assert_not @company.valid?
  end
end
