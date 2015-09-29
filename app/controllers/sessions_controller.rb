class SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      sign_in user
      redirect_back_or dashboard_path
    else
      flash.now[:danger] = 'Invalid email/password combination'
      redirect_to root_path
    end

  rescue
  	flash.now[:danger] = 'Invalid email/password combination'
    redirect_to root_path
  end

  def destroy
    sign_out
    redirect_to root_url
  end
end
