class AttendanceItem < ApplicationRecord
  belongs_to :attendance
  belongs_to :service
  belongs_to :collaborator, class_name: User, foreign_key: :user_id

  validate :collaborator_must_be_able_to_perform_the_service
  validate :finished_at_must_be_after_started_at

  scope :pending,         -> { where("started_at IS NULL") }
  scope :in_progress,     -> { where("started_at IS NOT NULL && finished_at IS NULL") }
  scope :finished,        -> { where("started_at IS NOT NULL && finished_at IS NOT NULL") }
  scope :by_collaborator, -> (collaborator) { where(user_id: collaborator.id) }

  def collaborator_must_be_able_to_perform_the_service
    if collaborator.present? && !collaborator.service_ids.include?(service_id)
      errors.add(:collaborator, "não está habilitado para executar o tratamento")
    end
  end

  def finished_at_must_be_after_started_at
    if started_at.present? && finished_at.present? && started_at > finished_at
      errors.add(:finished_at, "não pode ser antes do horário de início")
    end
  end
end
