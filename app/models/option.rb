class Option < ActiveRecord::Base
  belongs_to :question

  validates :answer, presence: true, length: {maximum: 50}
end
