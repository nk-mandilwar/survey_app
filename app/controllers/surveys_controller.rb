class SurveysController < ApplicationController
	before_action :authenticate_user!

	def create
		@survey = current_user.surveys.build(survey_params)
		@survey.save
		respond_to do |format|
			format.js
		end	
	end

	private

		def survey_params
			params.require(:survey).permit(:title)
		end	
end
