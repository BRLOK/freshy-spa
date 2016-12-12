class CustomerPolicy < ApplicationPolicy
  def index?
    user.admin? || user.operator?
  end

  def show?
    user.admin? || user.operator?
  end

  def create?
    user.admin? || user.operator?
  end

  def update?
    user.admin? || user.operator?
  end

  def activate?
    user.admin? || user.operator?
  end

  class Scope < Scope
    def resolve
      if user.admin? || user.operator?
        scope.all
      else
        scope.active
      end
    end
  end
end
