require 'test_helper'

class CompanyDeleteTest < ActionDispatch::IntegrationTest

  def setup
    User.delete_all
    attrs = attributes_for(:user)
    @user = User.new(attrs)
    @user.save
  end

  test "unsuccessful company delete" do
    
  end
  
  test "successful company delete" do
    
  end
  
  test "unsuccessful company edit" do
    
  end
  
  test "successful company edit" do
    
  end
  
  
end