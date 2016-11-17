class Survey < ActiveRecord::Base
  belongs_to :user
  has_many :questions, dependent: :destroy
  accepts_nested_attributes_for :questions, allow_destroy: true
  apply_simple_captcha message: "text does not match"

  scope :dup_surveys, -> (survey_id) { where(cloned_from: survey_id) }
  scope :published_surveys, -> { where(is_published: true) }

  before_save :title_format
  validates :title, presence: true, length: { maximum: 50 }, 
                                    uniqueness: { case_sensitive: false }, unless: :cloned_from
  validates :attendee, presence: true, if: :cloned_from

  def get_questions
    questions.includes(:options)
  end

  def destroy_clone_surveys
    surveys = Survey.dup_surveys(self.id)
    surveys.each do |survey|
      survey.destroy
    end
  end

  def self.get_feedback_for_user(surveys, user)
    current_user_feedbacks = []
      surveys.each do |survey|
      current_user_feedback = Survey.dup_surveys(survey.id).find_by(attendee: user.username)
      current_user_feedbacks << current_user_feedback
    end
    current_user_feedbacks
  end

  def self.get_same_question_answers(survey, questions)
    question_ids = get_same_question_ids(survey, questions)
    same_question_answers = []
    question_ids.each do |ids|
      question_answers = Answer.where(question_id: ids)
      same_question_answers << question_answers
    end
    same_question_answers
  end

  def self.get_same_question_ids(survey, questions)
    ids = get_feedback_ids(survey)
    question_ids = []
    questions.each do |question|
      same_questions = Question.where(query: question.query, survey_id: ids)
      same_query_ids = []
      same_questions.each do |question|
        same_query_ids << question.id
      end
      question_ids << same_query_ids
    end
    question_ids
  end

  def self.get_feedback_ids(survey)
    ids = []
    feedbacks = Survey.dup_surveys(survey.id)
    feedbacks.each do |feedback|
      ids << feedback.id
    end
    ids
  end

  def title_format
    self.title = title.downcase.capitalize
  end

end
