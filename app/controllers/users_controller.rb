class UsersController < ApplicationController
  before_action :signed_in_user, only: [:index, :edit, :update, :change_password, :update_password  ]
	before_action :correct_user,   only: [:edit, :update, :update_password]
	before_action :admin_user,     only: :destroy

  layout :custom_layout

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
    	flash[:success] = "Bienvenido a EasyCount!"
      redirect_to @user
    else
      flash.now[:error] = "No se pudo conectar"
      render 'pages/index'
    end
  end

  def show
    @user = User.find(params[:id])
    # TODO: Definir mecanismo para seleccionar la empresa actual
  end

  #get
  def change_password
    @user = User.find(params[:id])
  end

  #post
  def update_password
    @user = User.find(params[:id])
    if params[:user][:old_password] == User.digest(@user.password_digest)
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

    def password_params
      params.require(:user).permit(:password, :password_confirmation)
    end

    def custom_layout
      signed_in? ?  "dashboard" : "application"
    end
    # Before filters

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
