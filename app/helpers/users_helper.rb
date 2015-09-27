module UsersHelper
  # Before filters  

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end

  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end

  def init
    @user = User.find(params[:id])
    if @user.has_companies?
      @companies = @user.companies
      @current_company = @user.companies.find_by({:selected =>  true})
    end
  end
end
