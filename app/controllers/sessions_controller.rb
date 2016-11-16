class SessionsController < ApplicationController
  skip_before_filter :authorize
  layout false

  def new
  end

  def create
    user = User.find_by_email(params[:email])
    if user.present? && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to users_url
    else
      redirect_to login_url, alert: "E-mail ou senha inválida!"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to store_url, notice: "Logout com sucesso!"
  end
end
