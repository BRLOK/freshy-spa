class ApplicationController < ActionController::Base
  before_action :authorize
  protect_from_forgery with: :exception

  protected

  def authorize
    if User.find_by_id(session[:user_id]).blank?
      redirect_to login_url, notice: "Por favor faça o login"
    end
  end
end
