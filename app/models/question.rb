class Question < ActiveRecord::Base
  belongs_to :survey
  has_many :options, dependent: :destroy
  has_many :answers, dependent: :destroy
  accepts_nested_attributes_for :options, allow_destroy: true


  validates :query, presence: true, length: {maximum: 80}
  validate :category_in_values

  private

	  def category_in_values
	  	if category != 'Subjective' && category != "Multiple Choice" && 
	  												category != "Multiple Answers" && category == nil 
	  		errors.add(:category, "Category is Invalid")
	  	end
	  end

end
