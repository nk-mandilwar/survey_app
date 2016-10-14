class Question < ActiveRecord::Base
  belongs_to :survey
  has_many :options, dependent: :destroy
  has_many :survey_answers, dependent: :destroy

  validates :query, presence: true, length: {maximum: 80}
  validate :category_in_values
  validates_presence_of :no_of_options, if: :category_type? 
  validates :no_of_options, numericality: {only_integer: true, greater_than: 1,
  															 less_than_or_equal_to: 10}, allow_nil: true

  private

	  def category_in_values
	  	if category != 'Subjective' && category != "Multiple Choice" && 
	  																							category != "Multiple Answers"
	  		errors.add(:category, "Category is Invalid")
	  	end
	  end

	  def category_type?
	  	category != 'Subjective'
	  end	

end
