class UsersController < ApplicationController
  include UsersHelper

  before_action :signed_in_user, only: [:index, :edit, :update, :change_password, :update_password  ]
	before_action :correct_user,   only: [:edit, :update, :update_password]
	before_action :admin_user,     only: :destroy

  layout :custom_layout

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
    	flash[:success] = "Bienvenido a EasyCount!"
      redirect_to dashboard_path
    else
      flash[:error] = @user.errors
      redirect_to root_path
    end
  end

  def edit
    init
  end

  def update
    init

    if @user.update_attributes(edit_params)
      flash.now[:success] = "Datos actualizados"
      #@current_user = @user
      redirect_to @user
    else
      flash.now[:danger] = "No se pudo editar!"
      render 'edit'
    end
  end

  def show
    init
  end

  #get
  def change_password
    init
  end

  #post
  def update_password
    init

    if @user.authenticate(params[:user][:old_password])
      if @user.update_attributes(password_params)
        flash.now[:success] = "Contraseña actualizada"
        redirect_to @user
      else
        flash.now[:danger] = "No se pudo editar"
        render 'change_password'
      end
    else
      flash.now[:danger] = "La contraseña actual es incorrecta"
      render 'change_password'
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :producto, :email, :password,
                                   :password_confirmation, :avatar)
    end

    def edit_params
      params.require(:user).permit(:name, :email)
    end

    def password_params
      params.require(:user).permit(:password, :password_confirmation)
    end


end
