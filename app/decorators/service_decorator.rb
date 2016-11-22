class ServiceDecorator < Draper::Decorator
  delegate_all

  def description
    if object.description.present?
      object.description
    else
      '-'
    end
  end

  def short_description
    if description.length > 60
      description.truncate(60, separator: ' ')
    else
      description
    end
  end

  def active
    I18n.t object.active.to_s
  end
end
