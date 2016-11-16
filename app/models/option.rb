class Option < ActiveRecord::Base
  belongs_to :question
  before_save :answer_format
  validates :answer, presence: true, length: {maximum: 50}

  private
  	def answer_format
      self.answer = answer.downcase.capitalize
    end
end
