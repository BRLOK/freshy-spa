class UserPolicy < ApplicationPolicy
  def index?
    user.admin? || user.operator?
  end

  def show?
    user.admin? || user.operator?
  end

  def create?
    user.admin?
  end

  def update?
    user.admin? || user.operator?
  end

  def activate?
    user.admin?
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
