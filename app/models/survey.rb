class Survey < ActiveRecord::Base
  belongs_to :user
  has_many :questions, dependent: :destroy
  has_many :options, dependent: :destroy
  has_many :survey_answers, dependent: :destroy

  validates :title, presence: true, length: {maximum: 50}
end
