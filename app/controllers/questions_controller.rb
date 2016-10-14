class QuestionsController < ApplicationController
	before_action :authenticate_user!

	def create
		@question = Question.new(question_params)
		@question.save
		respond_to do |format|
			format.js
		end
	end

	private

		def question_params
			params.require(:question).permit(:query, :survey_id, :category, :no_of_options)
		end	
end
