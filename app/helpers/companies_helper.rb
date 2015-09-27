module CompaniesHelper
  def signed_in_user
    unless signed_in?
      store_location
      redirect_to root_url, notice: "Please sign in."
    end
  end

  def correct_user
    @user = User.find(params[:user_id])
    redirect_to(root_url) unless current_user?(@user)
  end

  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end

  #to be used where the user HAS companies
  def init(action)

    case action
    when "new"
      @user = User.find(params[:user_id])
      if @user.has_companies?
        @companies = @user.companies
        @current_company = @user.companies.find_by({:selected =>  true})
        @company = Company.new
      end
    when "index"
      @user = User.find(params[:user_id])
      if @user.has_companies?
        @companies = @user.companies
        @current_company = @user.companies.find_by({:selected =>  true})
      end
    when "show", "edit"
      @user = User.find(params[:user_id])
      if @user.has_companies?
        @companies = @user.companies
        @current_company = @user.companies.find_by({:selected =>  true})
        @company = @user.companies.find(params[:id])
      end
    when "update"
      @user = User.find(params[:user_id])
      @companies = @user.companies
      @current_company = @user.companies.find_by({:selected =>  true})
      @company = @user.companies.find(params[:id])
    end

  end
end
