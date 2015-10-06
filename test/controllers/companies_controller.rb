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
  end

  test "should redirect to user profile whene editing other company" do
    
  end
  
  test "should redirect to user profile whene deleting other company" do
    
  end
  
  test "should not allow to select other companies" do
    
  end
  
end
