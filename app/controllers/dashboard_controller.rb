class DashboardController < ApplicationController
  def index
    @attendances = policy_scope(Attendance).decorate
  end
end
