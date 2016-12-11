class AttendancesController < ApplicationController
  before_action :set_attendance, only: [:edit, :update, :start, :stop]

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

  def start
    @attendance.start!
  rescue => e
    flash[:error] = e.message
  ensure
    redirect_to @attendance
  end

  def stop
    @attendance.stop!
  rescue => e
    flash[:error] = e.message
  ensure
    redirect_to @attendance
  end

  def start_item
    @attendance_item = AttendanceItem.find(params[:id])
    @attendance_item.start!
  rescue => e
    flash[:error] = e.message
  ensure
    redirect_to @attendance_item.attendance
  end

  def stop_item
    @attendance_item = AttendanceItem.find(params[:id])
    @attendance_item.stop!
  rescue => e
    flash[:error] = e.message
  ensure
    redirect_to @attendance_item.attendance
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_attendance
    @attendance = Attendance.find(params[:id])
    authorize @attendance
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def attendance_params
    params.require(:attendance).permit(:customer_id, :status,
      scheduled_for: [:date, :time],
      items_attributes: [:id, :service_id, :user_id, :started_at, :finished_at, :_destroy])
  end
end
