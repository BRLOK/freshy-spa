class AttendanceItem < ApplicationRecord
  belongs_to :attendance
  belongs_to :service

  validate :finished_at_must_be_after_started_at

  scope :pending,         -> { where("started_at IS NULL") }
  scope :in_progress,     -> { where("started_at IS NOT NULL && finished_at IS NULL") }
  scope :finished,        -> { where("started_at IS NOT NULL && finished_at IS NOT NULL") }

  def finished_at_must_be_after_started_at
    if started_at.present? && finished_at.present? && started_at > finished_at
      errors.add(:finished_at, "não pode ser antes do horário de início")
    end
  end

  def start!
    if self.started_at.present? || !self.attendance.in_progress?
      raise "Não é possível iniciar este tratamento"
    else
      self.started_at = DateTime.current
      self.save!
    end
  end

  def stop!
    if self.finished_at.present? || !self.attendance.in_progress?
      raise "Não é possível encerrar este tratamento"
    else
      self.finished_at = DateTime.current
      self.save!
    end
  end
end
