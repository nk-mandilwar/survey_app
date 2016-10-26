class Question < ActiveRecord::Base
  belongs_to :survey
  has_many :options, dependent: :destroy
  has_many :answers, dependent: :destroy
  accepts_nested_attributes_for :options, allow_destroy: true


  validates :query, presence: true, length: {maximum: 80}
  validate :category_in_values

  amoeba do 
    include_association :options
  end

  enum category: { subjective: 0, multiple_choice: 1, multiple_answer: 2 }

  private

	  def category_in_values
	  	if category != 'subjective' && category != 'multiple_choice' && 
	  												category != "multiple_answer" && category != nil
	  		errors.add(:category, "is Invalid")
	  	end
	  end

end
