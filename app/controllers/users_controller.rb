class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update]

  # GET /users
  def index
    @users = policy_scope(User.order(:name)).decorate
  end

  # GET /users/1
  def show
    @user = User.find(params[:id]).decorate
    authorize @user
  end

  # GET /users/new
  def new
    @user = User.new
    authorize @user
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  def create
    @user = User.new(user_params)
    authorize @user
    respond_to do |format|
      if @user.save
        format.html { redirect_to users_url,
          notice: "#{@user.name} criado com sucesso." }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /users/1
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to users_url,
          notice: "#{@user.name} salvo com sucesso." }
      else
        format.html { render :edit }
      end
    end
  rescue StandardError => e
    render :edit
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
    authorize @user
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).
      permit(:name, :password, :password_confirmation, :email, :role, :active, service_ids: [])
  end
end
