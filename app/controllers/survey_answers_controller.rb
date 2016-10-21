class SurveyAnswersController < ApplicationController
	before_action :authenticate_user!

	def create
		@survey_answer = SurveyAnswer.create(survey_answer_params)
		binding.pry
		if @survey_answer.save_with_captcha
			redirect_to home_path, notice: "Feedback successfully recorde. Thank You!"
		else
			@clone_survey = Survey.find_by(id: survey_answer_params[:survey_id])
			@questions = @clone_survey.get_questions
			@errors = @survey_answer.errors
			@survey_answer = SurveyAnswer.new
			@survey_answer.answers.build
			render 'surveys/survey_form'
		end
	end

	private

		def survey_answer_params
			params.require(:survey_answer).permit(:email, :survey_id, :captcha, :captcha_key, 
																			answers_attributes: [:id, :question_id, :ans, multiple_ans:[]])
		end
end
