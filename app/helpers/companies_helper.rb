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
end
