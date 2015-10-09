require 'test_helper'

class CompanyVisualizationTest < ActionDispatch::IntegrationTest

  def setup
    User.delete_all
    attrs = attributes_for(:user)
    @user = User.new(attrs)
    @user.save
  end

  test "unsuccessful company visualization" do
    log_in_as(@user)
    
  end
  
  test "successful company visualization" do
    
  end
  
  test "unsuccessful company selection" do
      
  end
  
  test "successful company selection" do
      
  end
  
  test "successful companies visualization" do
      
  end
  
  test "successful companies visualization in user profile" do
      
  end
  
  test "should show default avatar image if no one suplied" do
      
  end
end