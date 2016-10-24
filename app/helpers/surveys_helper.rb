module SurveysHelper

	def set_survey_title(title)
		title.split(%r{_\s*}).last
	end

	def option_format(question, f)
		case question.category
		when "Subjective"
			render partial: "shared/subjective_field", locals: {f: f}
		when "Multiple Choice"
			render partial: "shared/radio_field", locals: {f: f, options: question.options}
	 	when "Multiple Answers"
			render partial: "shared/checkbox_field", locals: {f: f, options: question.options}
		end
	end

end
