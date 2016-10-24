class SurveysController < ApplicationController
	before_action :authenticate_user!
	before_action :check_survey_user_or_nil_survey, only: [:edit, :show, :update, :destroy, 
																																					:survey_feedback_form]

	def new
		@survey = Survey.new	
	end

	def create
		@survey = current_user.surveys.build(survey_params)
		if (@survey.save)
			duplicate_survey(@survey)
			redirect_to @survey, notice: "Successfully created!"
		else	
			render 'new'
		end	
	end

	def show
		@questions = @survey.get_questions
	end

	def my_surveys
		@my_surveys = current_user.original_surveys
	end

	def edit
	end

	def update
		if @survey.update(survey_params)
			duplicate_survey(@survey)
			redirect_to @survey, notice: 'Survey was successfully updated.'
		else
			render :edit
		end
	end

	def destroy
		@survey.destroy_orginal_and_clone_surveys
		respond_to do |format|
			format.html {redirect_to my_surveys_surveys_path, notice: "Successfully deleted."}
			format.js
		end
	end

	def survey_feedback_form
		@clone_survey = @survey.get_latest_clone_survey
		@questions = @clone_survey.get_questions
		@survey_answer = SurveyAnswer.new
		@survey_answer.answers.build
	end

	private

		def get_survey
			@survey = Survey.find_by(id: params[:id])
		end

		def check_survey_user_or_nil_survey 
			get_survey
			if @survey == nil || @survey.user_id != current_user.id
				redirect_to my_surveys_surveys_path, notice: "Can't access."
			end
			@survey
		end

		def survey_params
			params.require(:survey).permit(:title, questions_attributes: 
												[:id, :query, :category, :_destroy, options_attributes: [:id, :answer, :_destroy]])
		end	

		def duplicate_survey(survey)
			survey.class.amoeba do
				prepend title: "CloneFrom_#{survey.id}_"
			end
			@clone_survey = survey.amoeba_dup
			@clone_survey.save
		end
end
