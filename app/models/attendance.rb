class Attendance < ApplicationRecord
  belongs_to :customer
  belongs_to :collaborator, class_name: User, foreign_key: :user_id
  has_many :items, class_name: AttendanceItem
  has_many :services, through: :items
  accepts_nested_attributes_for :items, reject_if: :all_blank, allow_destroy: true
  accepts_date_time_params_for :scheduled_for

  VALID_STATUS = ["scheduled", "in_progress", "finished", "canceled"]

  validates :scheduled_for, presence: true
  validates :status, presence: true, inclusion: { in: VALID_STATUS }
  validate :customer_must_be_available
  validate :collaborator_must_be_available
  validate :collaborator_must_be_able_to_perform_service
  validate :scheduled_for_business_hours

  before_validation :set_default_status
  before_validation :set_duration

  scope :scheduled_for,         -> (date) { where(scheduled_for: date) }
  scope :scheduled_for_before,  -> (date) { where("scheduled_for >= ?", date) }
  scope :scheduled_for_after,   -> (date) { where("scheduled_for <= ?", date) }
  scope :by_collaborator,       -> (collaborator) { where(user_id: collaborator.id) }
  scope :pending,               -> { where(status: ["scheduled", "in_progress"]) }
  scope :except_canceled,       -> { where.not(status: "canceled") }

  VALID_STATUS.each do |some_status|
    define_method "#{some_status}?" do
      some_status == self.status
    end
  end

  def start_time
    self.scheduled_for.to_date
  end

  def expected_finish_time
    if self.duration.present?
      self.scheduled_for + self.duration * 60 - 60
    else
      self.scheduled_for + 60
    end
  end

  def start!
    if self.status != "scheduled"
      raise "Não é possível iniciar este atendimento"
    else
      self.status = "in_progress"
      self.save!
    end
  end

  def stop!
    if self.status != "in_progress"
      raise "Não é possível encerrar este atendimento"
    else
      self.status = "finished"
      self.save!
    end
  end

  def cancel!
    if self.status != "scheduled"
      raise "Não é possível cancelar este atendimento"
    else
      self.status = "canceled"
      self.save!
    end
  end

  private

  def set_default_status
    self.status ||= 'scheduled'
  end

  def set_duration
    if self.items.present?
      total_duration = 0
      self.items.each do |item|
        total_duration += item.service.duration
      end
      self.duration = total_duration
    end
  end

  def customer_must_be_available
    self.customer.attendances.pending.where.not(id: self.id).each do |attendance|
      if self.scheduled_for.between?(attendance.scheduled_for, attendance.expected_finish_time)
        self.errors.add(:customer, "já possui atendimento neste horário")
        return false
      end
    end
    return true
  end

  def collaborator_must_be_available
    self.collaborator.attendances.pending.where.not(id: self.id).each do |attendance|
      if self.scheduled_for.between?(attendance.scheduled_for, attendance.expected_finish_time)
        self.errors.add(:collaborator, "não está disponível")
        return false
      end
    end
    return true
  end

  def collaborator_must_be_able_to_perform_service
    if self.items.present?
      self.items.each do |item|
        if !item.service.user_ids.include?(self.user_id)
          self.errors.add(:base, "#{item.service.name} não pode ser executado pelo colaborador")
          return false
        end
      end
    end
    return true
  end

  def scheduled_for_business_hours
    if scheduled_for < (scheduled_for.beginning_of_day + 8.hours) || scheduled_for > (scheduled_for.end_of_day + 22.hours)
      self.errors.add(:scheduled_for, "está fora do expediente")
    end
  end
end
