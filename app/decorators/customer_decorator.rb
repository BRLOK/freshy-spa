class CustomerDecorator < Draper::Decorator
  delegate_all

  def email
    if object.email.present?
      object.email
    else
      "-"
    end
  end

  def cpf
    if object.cpf.present?
      object.cpf
    else
      "-"
    end
  end

  def telephone
    if object.telephone.present?
      object.telephone
    else
      "-"
    end
  end

  def active
    I18n.t object.active.to_s
  end
end
