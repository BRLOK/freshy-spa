class SessionsController < ApplicationController
  skip_before_filter :authorize_user
  layout false

  def new
  end

  def create
    user = User.find_by_email(params[:email])
    if user.present?
      if !user.active?
        message = "Usuário desativado."
      elsif user.authenticate(params[:password])
        session[:auth_token] = user.auth_token
      else
        message = "Senha inválida!"
      end
    else
      message = "E-mail inválido!"
    end

    if message.present?
      redirect_to login_path, alert: message
    else
      redirect_to root_path
    end
  end

  def destroy
    session[:auth_token] = nil
    redirect_to login_url, notice: "Sessão encerrada com sucesso!"
  end
end
