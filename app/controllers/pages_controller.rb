class PagesController < ApplicationController
  def index
    @user = User.new
    if signed_in? 
      redirect_to @current_user
    end
  end
end
