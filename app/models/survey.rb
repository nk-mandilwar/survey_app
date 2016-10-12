class Survey < ActiveRecord::Base
  belongs_to :user
  has_many :questions
  has_many :options
  has_many :survey_answers
end
