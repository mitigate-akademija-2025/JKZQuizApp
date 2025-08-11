class Question < ApplicationRecord
  belongs_to :entry

  validates :text, presence: true

end
