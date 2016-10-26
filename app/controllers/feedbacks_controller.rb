class FeedbacksController < ApplicationController
	before_action :authenticate_user!
	before_action :check_survey_user_or_nil_survey, only: :answers

	def create
		@feedback = Feedback.create(feedback_params)
		if @feedback.save_with_captcha
			redirect_to home_path, notice: "Feedback successfully recorde. Thank You!"
		else
			@clone_survey = Survey.find_by(id: feedback_params[:survey_id])
			@questions = @clone_survey.get_questions
			@errors = @feedback.errors
			@feedback = Feedback.new
			@feedback.answers.build
			render 'surveys/survey_feedback_form'
		end
	end

	def answers
		@clone_surveys = @survey.get_clone_surveys.includes(:questions, 
															:feedbacks => :answers).paginate(page: params[:page], per_page: 1)
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

		def feedback_params
			params.require(:feedback).permit(:email, :survey_id, :captcha, :captcha_key, 
																			answers_attributes: [:id, :question_id, :ans, multiple_ans:[]])
		end
end
