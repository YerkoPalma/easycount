module SessionsHelper

  def log_in(user)
    session[:user_id] = user.id
    remember_token = User.new_remember_token
    cookies.permanent[:remember_token] = remember_token
    user.update_attribute(:remember_token, User.digest(remember_token))
    self.current_user = user
  end

  def logged_in?
    !current_user.nil?
  end

  #deprecated
  def sign_in(user)
    remember_token = User.new_remember_token
    cookies.permanent[:remember_token] = remember_token
    user.update_attribute(:remember_token, User.digest(remember_token))
    self.current_user = user
  end

  #deprecated
  def signed_in?
    !current_user.nil?
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  rescue
    @current_user = nil
  end
  #deprecated
  #def current_user
  #  remember_token = User.digest(cookies[:remember_token])
  #  @current_user ||= User.find_by(remember_token: remember_token)
  #rescue
  #  @current_user = nil
  #end

  def current_user?(user)
    user == current_user
  end

  def log_out
    current_user.update_attribute(:remember_token,
                                  User.digest(User.new_remember_token))
    cookies.delete(:remember_token)
    self.current_user = nil
    session.delete(:user_id)
    @current_user = nil
  end

  #deprecated
  def sign_out
    current_user.update_attribute(:remember_token,
                                  User.digest(User.new_remember_token))
    cookies.delete(:remember_token)
    self.current_user = nil
    current_user = nil
    @current_user = nil
  end

  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end

  def store_location
    session[:return_to] = request.url if request.get?
  end

  def signed_in_user
    unless logged_in?
      store_location
      flash.now[:danger] = "Debes estar conectado para acceder acá"
      redirect_to root_url, danger: "Debes estar conectado para acceder acá."
    end
  end
end
