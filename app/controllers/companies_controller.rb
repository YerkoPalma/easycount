class CompaniesController < ApplicationController
  include CompaniesHelper
  before_action :signed_in_user, only: [:new, :index, :show, :select, :edit, :create, :update, :destroy ]
  # before_action :correct_user,   only: [:edit, :update, :update_password]

  layout :custom_layout

  def new
    init "new"
  end

  def edit
    init "edit"
  end

  def update
    init "update"

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
    init "index"
    redirect_to @user unless @user.has_companies?
  end

  def show
    init "show"
  end

  def create
    @user = User.find(params[:user_id])
    @company = @user.companies.new(company_params)

    @current_company = @user.companies.find_by({:selected =>  true}) rescue nil

    if @current_company.nil?
      @company.update_attributes(:selected => true)
    end

    if @company.save
      flash[:success] = "Compañia " + @company.name + " exitosamente ingresada"
      redirect_to @user
    else
      flash[:danger] = "No se pudo ingresar tu empresa"
      redirect_to @user
    end
  end

  def destroy
    @user = User.find(params[:user_id])
    @companies = @user.companies
    @company = @user.companies.find(params[:id])
    if @company.delete
      render "index"
    end
    flash[:danger] = "No se pudo eliminar la empresa"
  end

  private
    def company_params
      params.require(:company).permit(:rut, :name, :description, :avatar, :selected)
    end
end
