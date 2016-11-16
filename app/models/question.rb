class Question < ActiveRecord::Base
  belongs_to :survey
  has_many :options, dependent: :destroy
  has_many :answers, dependent: :destroy
  accepts_nested_attributes_for :options, allow_destroy: true
  accepts_nested_attributes_for :answers

  before_save :query_format

  validates :query, presence: true, length: {maximum: 80}
  validate :category_in_values

  enum category: { subjective: 0, multiple_choice: 1, multiple_answer: 2 }

  private

	  def category_in_values
	  	if category != 'subjective' && category != 'multiple_choice' && 
	  												category != "multiple_answer" && category != nil
	  		errors.add(:category, "is Invalid")
	  	end
	  end

    def query_format
      self.query = query.downcase.capitalize
      self.query = (query + '?') unless query.end_with? '?'
    end

end
