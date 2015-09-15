class CompaniesController < ApplicationController
  before_action :signed_in_user, only: [:new  ]

  layout :custom_layout

  def new
    @user = User.find(params[:user_id])
  end
  
  def create
    @user = User.find(params[:user_id])
    @company = @user.companies.new(company_params)
    if @company.save
      flash[:success] = "Compañia " + @company.name + " exitosamente ingresada"
      redirect_to @user
    else
      flash.now[:error] = "No se ingresar tu empresa"
      render 'pages/index'
    end
  end


  private
    def company_params
      params.require(:company).permit(:rut, :name, :description)
    end
  
    def custom_layout
      signed_in? ?  "dashboard" : "application"
    end

    def signed_in_user
      unless signed_in?
        store_location
        redirect_to root_url, notice: "Please sign in."
      end
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
