class Entry < ApplicationRecord
  belongs_to :user

  validates :description, presence: { message: "can't be blank. Please describe the quiz." }
  validate :description_should_be_valid
  validates :name, presence: { message: "can't be blank. Please provide a name for the quiz." }

  # encrypts :name, deterministic: true

  private

  def description_should_be_valid
    if description.present? && description.length < 10
      errors.add(:description, "is too short. Please provide more details.")
    end
  end
end
