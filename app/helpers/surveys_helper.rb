module SurveysHelper

	def set_survey_title(title)
		title.split(%r{_\s*}).last
	end
end
