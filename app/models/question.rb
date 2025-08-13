class Question < ApplicationRecord
  belongs_to :entry
  has_many :answers, dependent: :destroy

  validates :text, presence: true

end
