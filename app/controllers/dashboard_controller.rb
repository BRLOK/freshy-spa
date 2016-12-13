class DashboardController < ApplicationController
  def index
    @attendances = policy_scope(Attendance.except_canceled).decorate
  end
end
