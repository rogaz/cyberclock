#encoding: utf-8
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  #protect_from_forgery with: :exception
  protect_from_forgery with: :null_session
  before_filter :require_user
  #TODO: Hacer funcionar cancan, probablemente utilizando esta otra gema 'cancan_strong_parameters'
  #load_and_authorize_resource

  helper :all
  helper_method :current_user_session, :current_user

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to home_url, :alert => 'Permiso denegado'
    #TODO: Verificar como funciona este método
    #redirect_to_back_or_default home_url, :alert => 'Permiso denegado'
  end

  private
  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end

  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.user
  end

  def require_user
    unless current_user
      store_location
      flash[:danger] = 'Debe iniciar sesión.'
      redirect_to root_url
      return false
    end
  end

  def store_location
    session[:return_to] = request.url
  end

  def redirect_back_or_default(default)
    redirect_to(session[:return_to] || default)
    session[:return_to] = nil
  end

  def home_url
    if current_user.is_admin?
      companies_url
    elsif current_user.is_admin_company?
      company_url(Company.find_by_admin_id(current_user))
    elsif current_user.is_admin_branch?
      branch_url(Branch.find_by_admin_id(current_user))
    elsif current_user.is_user?
      #TODO: redireccionar al show de computer correspondiente
      branches_url
    else
      branches_url
    end
  end

end
