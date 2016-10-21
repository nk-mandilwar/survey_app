class Survey < ActiveRecord::Base
  belongs_to :user
  has_many :questions, dependent: :destroy
  has_many :survey_answers, dependent: :destroy
  accepts_nested_attributes_for :questions, allow_destroy: true

  validates :title, presence: true, length: {maximum: 50}

  amoeba do 
  	enable
  end

  def get_questions
    questions.includes(:options)
  end

  def get_latest_clone_survey
    Survey.where("title LIKE ?", "CloneFrom_#{id}%").order(created_at: :desc).first
  end
end
