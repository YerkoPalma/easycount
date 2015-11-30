class CompaniesController < ApplicationController
  include CompaniesHelper
  before_action :signed_in_user, only: [:new, :index, :show, :select, :edit, :create, :update, :destroy ]
  before_action :correct_user,   only: [:destroy]

  layout :custom_layout

  def new
    init "new"
    get_regiones
  end

  def edit
    init "edit"
  end

  def update
    init "update"

    if @company.update_attributes(company_params)
      flash.now[:success] = "Datos actualizados"

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

    if @company.save
      flash[:success] = "Compañia " + @company.name + " exitosamente ingresada"
      get_regiones
      @company_tab = "empresa"

      if @current_company.nil?
        @company.update_attributes(:selected => true)
        @current_company = @company
      end

      #falta actualizar la variable que indica el tab actual
      render "new"
    else
      #@errors = @company.errors
      flash[:company_error] = @company.errors.full_messages
      redirect_to @user
    end
  end

  #Falta luego agregar una forma de continuar el ingreso de la empresa

  #completar
  def create_company_data
    @user = User.find(params[:user_id])
    @current_company = @user.companies.find_by({:selected =>  true})
    @company = @user.companies.find(params[:id])

    if @company.update_attributes(company_data_params)
      flash[:success] = "Datos actualizados"

      redirect_to user_company_path(@user,@company)
    else
      flash[:danger] = "No se pudo editar!"
      render 'new'
    end
  end

  def destroy
    @user = User.find(params[:user_id])
    @companies = @user.companies
    @company = @user.companies.find(params[:id])
    if @company.delete
      flash[:success] = "Empresa eliminada exitosamente"
      redirect_to dashboard_path
    else
      flash.now[:danger] = "No se pudo eliminar la empresa"
      render "index"
    end

  end

  private
    def company_params
      params.require(:company).permit(:rut, :name, :giro, :direccion, :comuna, :region, :description, :avatar, :selected, :rut_representante, :name_representante)
    end

    def company_data_params
      params.require(:company).permit(:cargos => [:name, :code], :sucursales => [:name, :code, :address], :departamentos => [:name, :code])
    end
end
