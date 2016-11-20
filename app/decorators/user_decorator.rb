class UserDecorator < Draper::Decorator
  delegate_all

  def role
    I18n.t "enums.user.role.#{object.role}"
  end

  def active
    I18n.t object.active.to_s
  end
end
