class ServicesController < ApplicationController
  before_action :set_service, only: [:show, :edit, :update]

  # GET /services
  def index
    @services = Service.order(:name)
  end

  # GET /services/1
  def show
  end

  # GET /services/new
  def new
    @service = Service.new
  end

  # GET /services/1/edit
  def edit
  end

  # POST /services
  def create
    @service = Service.new(service_params)

    respond_to do |format|
      if @service.save
        format.html { redirect_to services_url,
          notice: "#{@service.name} criado com sucesso." }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /services/1
  def update
    respond_to do |format|
      if @service.update(service_params)
        format.html { redirect_to services_url,
          notice: "#{@service.name} salvo com sucesso." }
      else
        format.html { render :edit }
      end
    end
  rescue StandardError => e
    render :edit
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_service
    @service = Service.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def service_params
    params.require(:service).
      permit(:name, :description, :duration, :active)
  end
end
