class AttendancesController < ApplicationController
  before_action :set_attendance, only: [:edit, :update]

  # GET /attendances
  def index
    @attendances = policy_scope(Attendance.order(scheduled_for: :desc)).decorate
  end

  # GET /attendances/1
  def show
    @attendance = Attendance.find(params[:id]).decorate
    authorize @attendance
  end

  # GET /attendances/new
  def new
    @attendance = Attendance.new(status: "scheduled")
    authorize @attendance
  end

  # GET /attendances/1/edit
  def edit
  end

  # POST /attendances
  def create
    @attendance = Attendance.new(attendance_params)
    authorize @attendance
    respond_to do |format|
      if @attendance.save
        format.html { redirect_to attendances_url,
          notice: "Atendimento criado com sucesso." }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /attendances/1
  def update
    respond_to do |format|
      if @attendance.update(attendance_params)
        format.html { redirect_to attendances_url,
          notice: "Atendimento salvo com sucesso." }
      else
        format.html { render :edit }
      end
    end
  rescue StandardError => e
    render :edit
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_attendance
    @attendance = Attendance.find(params[:id])
    authorize @attendance
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def attendance_params
    params.require(:attendance).
      permit(:customer_id, :scheduled_for, :status)
  end
end
