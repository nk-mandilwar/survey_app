class Survey < ActiveRecord::Base
  belongs_to :user
  has_many :questions, dependent: :destroy
  accepts_nested_attributes_for :questions, allow_destroy: true
  apply_simple_captcha message: "text does not match"

  scope :dup_surveys, -> (survey_id) { where(cloned_from: survey_id) }
  scope :published_surveys, -> { where(is_published: true) }

  validates :title, presence: true, length: { maximum: 50 }
  validates :attendee, presence: true, uniqueness: { case_sensitive: false} , if: :cloned_from


  self.per_page = 10

  def get_questions
    questions.includes(:options)
  end

  def destroy_clone_surveys
    surveys = Survey.dup_surveys(self.id)
    surveys.each do |survey|
      survey.destroy
    end
  end

  def self.get_current_user_feedback(surveys, current_user)
    current_user_feedbacks = []
      surveys.each do |survey|
      current_user_feedback = Survey.dup_surveys(survey.id).find_by(attendee: current_user.username)
      current_user_feedbacks << current_user_feedback
    end
    current_user_feedbacks
  end

  def self.get_same_question_answers(survey, questions)
    ids = []
    feedbacks = Survey.dup_surveys(survey.id)
    feedbacks.each do |feedback|
      ids << feedback.id
    end
    question_ids = []
    questions.each do |question|
      same_questions = Question.where(query: question.query, survey_id: ids)
      same_query_ids = []
      same_questions.each do |question|
        same_query_ids << question.id
      end
      question_ids << same_query_ids
    end
    same_question_answers = []
    question_ids.each do |ids|
      question_answers = Answer.where(question_id: ids)
      same_question_answers << question_answers
    end
    same_question_answers
  end
end
