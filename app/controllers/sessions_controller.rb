class SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      redirect_back_or dashboard_path
    else
      flash[:danger] = !user.nil? && user.errors.any? ? user.errors : 'Invalid email/password combination'
      redirect_to root_path
    end

  rescue
  	flash[:danger] = !user.nil? && user.errors.any? ? user.errors : 'Invalid email/password combination'
    redirect_to root_path
  end

  def destroy
    log_out
    redirect_to root_url
  end
end
