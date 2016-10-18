class Survey < ActiveRecord::Base
  belongs_to :user
  has_many :questions, dependent: :destroy
  has_many :survey_answers, dependent: :destroy
  accepts_nested_attributes_for :questions, allow_destroy: true

  validates :title, presence: true, length: {maximum: 50}
end
