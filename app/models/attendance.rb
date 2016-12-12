class Attendance < ApplicationRecord
  belongs_to :customer
  has_many :items, class_name: AttendanceItem
  has_many :services, through: :attendance_items
  has_many :collaborators, through: :attendance_items, class_name: User
  accepts_nested_attributes_for :items
  accepts_date_time_params_for :scheduled_for

  VALID_STATUS = ["scheduled", "in_progress", "finished", "canceled"]

  validates :scheduled_for, presence: true
  validates :status, presence: true, inclusion: { in: VALID_STATUS }

  before_validation :set_default_status

  scope :scheduled_for,         -> (date) { where(scheduled_for: date) }
  scope :scheduled_for_before,  -> (date) { where("scheduled_for >= ?", date) }
  scope :scheduled_for_after,   -> (date) { where("scheduled_for <= ?", date) }
  scope :by_collaborator,       -> (collaborator) { joins(:items).merge(AttendanceItem.by_collaborator(collaborator)).uniq }

  VALID_STATUS.each do |some_status|
    define_method "#{some_status}?" do
      some_status == self.status
    end
  end

  def start_time
    self.scheduled_for.to_date
  end

  def set_default_status
    self.status ||= 'scheduled'
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
end
