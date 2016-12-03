class SessionsController < ApplicationController
  skip_before_filter :authorize_user
  layout false

  def new
  end

  def create
    user = User.active.find_by_email(params[:email])
    if user.present? && user.authenticate(params[:password])
      session[:auth_token] = user.auth_token
      redirect_to root_path
    else
      redirect_to login_url, alert: "E-mail ou senha inválida!"
    end
  end

  def destroy
    session[:auth_token] = nil
    redirect_to login_url, notice: "Logout com sucesso!"
  end
end
