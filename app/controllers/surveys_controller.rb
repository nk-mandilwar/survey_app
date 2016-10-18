class SurveysController < ApplicationController
	before_action :authenticate_user!
	before_action :get_survey, only: [:edit, :show, :update, :destroy]

	def new
		@survey = Survey.new	
	end

	def create
		@survey = current_user.surveys.build(survey_params)
		if (@survey.save)
			redirect_to @survey, notice: "Successfully created!"
		else	
			render 'new'
		end	
	end

	def show
		check_survey_user_or_nil_survey @survey
	end

	def my_surveys
		@my_surveys = current_user.surveys
	end

	def edit
		check_survey_user_or_nil_survey @survey
	end

	def update
		check_survey_user_or_nil_survey @survey	
		if @survey.update(survey_params)
			redirect_to @survey, notice: 'Survey was successfully updated.'
		else
			render :edit
		end
	end

	def destroy
		check_survey_user_or_nil_survey @survey
		@survey.destroy
		respond_to do |format|
			format.html {redirect_to my_surveys_surveys_path, notice: "Successfully deleted."}
			format.js
		end
	end

	private

		def get_survey
			@survey = Survey.find_by(id: params[:id])
		end

		def check_survey_user_or_nil_survey survey
			if survey == nil || survey.user_id != current_user.id
				redirect_to my_surveys_surveys_path, notice: "Can't access."
			end
		end

		def survey_params
			params.require(:survey).permit(:title, questions_attributes: 
												[:id, :query, :category, :_destroy, options_attributes: [:id, :answer, :_destroy]])
		end	
end
