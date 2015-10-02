require 'test_helper'

class CompanyTest < ActiveSupport::TestCase
  
  def setup
    User.delete_all
    attrs = attributes_for(:user)
    @user = User.new(attrs)
    @user.save
    @company = @user.companies.new(rut: 723456789, name: "Acme", description: "Una empresa Acme", selected: false)
    
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
  
  test "rut should be more than 72000000" do
    @company.rut = 719999991
    assert_not @company.valid?
  end
end