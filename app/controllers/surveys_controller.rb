class SurveysController < ApplicationController
	before_action :authenticate_user!
	before_action :check_survey_user, only: [:edit, :show, :update, :destroy, 
																					:feedbacks, :published, :unpublished, :analyze]
	before_action :check_published, only: :new_feedback																					 					
	
	def index
		@surveys = Survey.published_surveys.paginate(page: params[:page], per_page: 10)
		@current_user_feedbacks = Survey.get_feedback_for_user(@surveys, current_user)
	end

	def my_surveys
		@my_surveys = current_user.surveys.paginate(page: params[:page], per_page: 10)
	end

	def show
		@questions = @survey.get_questions
	end

	def new
		@survey = Survey.new	
	end

	def create
		@survey = current_user.surveys.build(survey_params)
		begin
			if (@survey.save)
				redirect_to @survey, notice: "Successfully created!"
			else	
				render 'new'
			end
		rescue
			@survey.errors[:base] = "Questions cannot be same. Options for a question cannot be same."
			render 'new'
		end
	end

	def edit
		if @survey.is_published
			redirect_to my_surveys_surveys_path, notice: "You can't edit a published survey!"
		end
	end

	def update
		@survey.destroy_clone_surveys
		if @survey.update(survey_params)
			redirect_to @survey, notice: "Survey was successfully updated."
		else
			render :edit
		end
	end

	def destroy
		@survey.destroy
		@survey.destroy_clone_surveys
		respond_to do |format|
			format.html {redirect_to my_surveys_surveys_path, notice: "Successfully deleted."}
			format.js
		end
	end

	def published
		@survey.update_columns(is_published: true)
		redirect_to :back, notice: "Successfully published."
	end

	def unpublished
		@survey.update_columns(is_published: false)
		redirect_to :back, notice: "Successfully unpublished."
	end

	def new_feedback
		@feedback = Survey.new
		@feedback.questions.build do |question|
			question.answers.build
		end
		@questions = @survey.get_questions
	end

	def create_feedback
		if check_attendee_uniqueness?(survey_feedback_params[:cloned_from], survey_feedback_params[:attendee])
			redirect_to surveys_path, notice: "You have already submitted your feedback!" 
		else
			@feedback = Survey.new(survey_feedback_params)
			if @feedback.save_with_captcha
				redirect_to surveys_path, notice: "Response recorded successfully. Thank You!"
			else
				@survey = Survey.find_by(id: params[:survey][:cloned_from])
				@questions = @survey.get_questions
				@errors = @feedback.errors
				@feedback = Survey.new
				@feedback.questions.build do |question|
					question.answers.build
				end
				render 'new_feedback'
			end
		end
	end

	def feedbacks
		@feedbacks = Survey.dup_surveys(@survey.id).includes(questions: :answers).
																								paginate(page: params[:page], per_page: 10)
	end

	def analyze
		@questions = @survey.get_questions
		@same_question_answers = Survey.get_same_question_answers(@survey, @questions)
	end

	private

		def get_survey
			@survey = Survey.find_by(id: params[:id])
		end

		def check_nil_survey
			get_survey
      if !@survey
        redirect_to my_surveys_surveys_path, notice: "Does not exist."
      end
      @survey
    end

		def check_survey_user
      if check_nil_survey
      	if @survey.user_id != current_user.id
        	redirect_to my_surveys_surveys_path, notice: "Can't access."
      	end
      end
      @survey
    end

    def check_published
    	if check_nil_survey
    		if !@survey.is_published
    			redirect_to surveys_path, notice: "Survey yet to be published"
    		end
    	end
    	@survey
    end

    def check_attendee_uniqueness?(cloned_from, attendee)
    	Survey.where(cloned_from: cloned_from, attendee: attendee).any?
  	end

		def survey_params
			params.require(:survey).permit(:title, questions_attributes: [:id, :query, :category, :_destroy, 
																																	 options_attributes: [:id, :answer, :_destroy]])
		end

		def survey_feedback_params
			params.require(:survey).permit(:title, :cloned_from, :attendee, :captcha, :captcha_key, 
																		 questions_attributes: [:id, :query, :category, 
																		 											 answers_attributes: [:id, :ans, multiple_ans:[]]])
		end	
end
