class ApplicationController < ActionController::Base
  before_action :authorize_user
  include Pundit
  protect_from_forgery with: :exception
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def current_user
    @current_user ||= User.find_by_auth_token(session[:auth_token])
  end

  protected

  def authorize_user
    if current_user.blank?
      redirect_to login_url, notice: "Por favor faça o login"
    end
  end

  private

  def user_not_authorized
    flash[:alert] = "Você não está autorizado a realizar esta ação."
    redirect_to(request.referrer || root_path)
  end
end
