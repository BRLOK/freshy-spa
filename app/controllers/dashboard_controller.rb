class DashboardController < ApplicationController
  def index
    @attendances = policy_scope(Attendance.order(scheduled_for: :desc)).decorate
  end
end
