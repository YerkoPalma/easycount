class CompaniesController < ApplicationController
  include CompaniesHelper
  before_action :signed_in_user, only: [:new, :index, :show, :select, :edit ]
  # before_action :correct_user,   only: [:edit, :update, :update_password]

  layout :custom_layout

  def new
    @user = User.find(params[:user_id])
    if @user.has_companies?
      @companies = @user.companies
      @current_company = @user.companies.find_by({:selected =>  true})
      @company = Company.new
    end
  end

  def edit
    @user = User.find(params[:user_id])
    if @user.has_companies?
      @companies = @user.companies
      @company = @user.companies.find(params[:id])
      @current_company = @user.companies.find_by({:selected =>  true})
    end
  end

  def update
    @user = User.find(params[:user_id])
    @companies = @user.companies
    @current_company = @user.companies.find_by({:selected =>  true})
    @company = @user.companies.find(params[:id])

    if @company.update_attributes(company_params)
      flash.now[:success] = "Datos actualizados"
      #@current_user = @user
      redirect_to user_company_path(@user,@company)
    else
      flash.now[:danger] = "No se pudo editar!"
      render 'edit'
    end
  end

  def select
    @user = User.find(params[:user_id])
    @companies = @user.companies

    #deselect current selected company
    @old_company = @user.companies.find_by({:selected =>  true})
    @old_company.update_attributes(:selected => false)
    #select company
    @current_company = @user.companies.find(params[:company_id])
    @current_company.update_attributes(:selected => true)

    render "index"
  end

  def index
    @user = User.find(params[:user_id])
    if @user.has_companies?
      @companies = @user.companies
      @current_company = @user.companies.find_by({:selected =>  true})
    end
  end

  def show
    @user = User.find(params[:user_id])
    if @user.has_companies?
      @companies = @user.companies
      @current_company = @user.companies.find_by({:selected =>  true})
      #The company being showed
      @company = @user.companies.find(params[:id])
    end
  end

  def create
    @user = User.find(params[:user_id])
    @company = @user.companies.new(company_params)

    @current_company = @user.companies.find_by({:selected =>  true}) rescue nil

    if @current_company.nil?
      @company.update_attributes(:selected => true)
    end
    #des-selecciono las compañias anteriores
    #@user.update_attributes("companies.selected" => false)
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
      params.require(:company).permit(:rut, :name, :description, :avatar, :selected)
    end
end
