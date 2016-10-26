module SurveysHelper

	def set_survey_title(title)
		title.split(%r{_\s*}).last
	end

	def option_format(question, f)
		if question.subjective?
			render partial: "shared/subjective_field", locals: {f: f}
		elsif question.multiple_choice?
			render partial: "shared/radio_field", locals: {f: f, options: question.options}
	 	else
			render partial: "shared/checkbox_field", locals: {f: f, options: question.options}
		end
	end

end
