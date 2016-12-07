class AttendancePolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    true
  end

  def create?
    user.admin? || user.operator?
  end

  def update?
    user.admin? || user.operator?
  end

  class Scope < Scope
    def resolve
      if user.admin? || user.operator?
        scope.all
      else
        scope.by_collaborator(user)
      end
    end
  end
end
