class PagesController < ApplicationController
  before_action :signed_in_user, only: [:dashboard ]

  layout :custom_layout

  def index
    @user = User.new
    if signed_in?
      redirect_to @current_user
    end
  end

  def dashboard
    @user = @current_user
    if @current_user.has_companies?
      @current_company = @current_user.companies.find_by({:selected =>  true})
    end
  end
end
