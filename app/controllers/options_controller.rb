class OptionsController < ApplicationController
	before_action :authenticate_user!

	def create
		@option_id = option_params[:option_id]
		@option = Option.new(create_option_params)
		@option.save
		respond_to do |format|
			format.js
		end
	end

	private

		def option_params
			params.require(:option).permit(:answer, :survey_id, :question_id, :option_id)
		end	

		def create_option_params
			option_params.slice(:answer, :survey_id, :question_id)
		end	
end
