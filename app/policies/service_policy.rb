class ServicePolicy < ApplicationPolicy
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
      if user.admin?
        scope.all
      else
        scope.active
      end
    end
  end
end
