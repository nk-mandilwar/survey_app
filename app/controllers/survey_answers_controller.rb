class SurveyAnswersController < ApplicationController
	before_action :authenticate_user!
	before_action :check_survey_user_or_nil_survey, only: :answers

	def create
		@survey_answer = SurveyAnswer.create(survey_answer_params)
		if @survey_answer.save_with_captcha
			redirect_to home_path, notice: "Feedback successfully recorde. Thank You!"
		else
			@clone_survey = Survey.find_by(id: survey_answer_params[:survey_id])
			@questions = @clone_survey.get_questions
			@errors = @survey_answer.errors
			@survey_answer = SurveyAnswer.new
			@survey_answer.answers.build
			render 'surveys/survey_feedback_form'
		end
	end

	def answers
		@clone_surveys = @survey.get_clone_surveys.includes(:questions, :survey_answers => :answers)
	end

	private

		def get_survey
			@survey = Survey.find_by(id: params[:survey_id])
		end

		def check_survey_user_or_nil_survey 
			get_survey
			if @survey == nil || @survey.user_id != current_user.id
				redirect_to my_surveys_surveys_path, notice: "Can't access."
			end
			@survey
		end

		def survey_answer_params
			params.require(:survey_answer).permit(:email, :survey_id, :captcha, :captcha_key, 
																			answers_attributes: [:id, :question_id, :ans, multiple_ans:[]])
		end
end
