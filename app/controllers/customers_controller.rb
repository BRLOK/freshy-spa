class CustomersController < ApplicationController
  before_action :set_customer, only: [:edit, :update]

  # GET /customers
  def index
    @customers = policy_scope(Customer.order(:name)).decorate
  end

  # GET /customers/1
  def show
    @customer = Customer.find(params[:id]).decorate
    authorize @customer
  end

  # GET /customers/new
  def new
    @customer = Customer.new
    authorize @customer
  end

  # GET /customers/1/edit
  def edit
  end

  # POST /customers
  def create
    @customer = Customer.new(customer_params)
    authorize @customer
    respond_to do |format|
      if @customer.save
        format.html { redirect_to customers_url,
          notice: "#{@customer.name} criado com sucesso." }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /customers/1
  def update
    respond_to do |format|
      if @customer.update(customer_params)
        format.html { redirect_to customers_url,
          notice: "#{@customer.name} salvo com sucesso." }
      else
        format.html { render :edit }
      end
    end
  rescue StandardError => e
    render :edit
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_customer
    @customer = Customer.find(params[:id])
    authorize @customer
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def customer_params
    params.require(:customer).
      permit(:name, :email, :cpf, :telephone, :active)
  end
end
