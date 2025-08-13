class Question < ApplicationRecord
  belongs_to :entry
  has_many :answers, dependent: :destroy
  accepts_nested_attributes_for :answers


  validates :text, presence: true

end
