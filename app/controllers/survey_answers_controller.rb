class SurveyAnswersController < ApplicationController
	before_action :authenticate_user!

	def create
		@survey_answer = SurveyAnswer.create(survey_answer_params)
		binding.pry
		if @survey_answer.save
			redirect_to home_path
		else
			@survey = Survey.find_by(params[:survey_id])
			@questions = @survey.get_questions
			render 'surveys/survey_form'
		end
	end

	private

		def survey_answer_params
			params.require(:survey_answer).permit(:email, :survey_id, 
																			answers_attributes: [:id, :question_id, :ans, multiple_ans:[]])
		end

end
