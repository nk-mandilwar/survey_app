module SurveysHelper

	def option_format(question, f)
		if question.subjective?
			render partial: "shared/subjective_field", locals: {f: f}
		elsif question.multiple_choice?
			render partial: "shared/radio_field", locals: {f: f, options: question.options}
	 	else
			render partial: "shared/checkbox_field", locals: {f: f, options: question.options}
		end
	end

	def get_answers(answer)
		if(answer.ans != nil)
			answer.ans
		else
			answers = fetch_multiple_answers(answer)
			render partial: "shared/display_answer", locals: {answers: answers}
		end	
	end

	def fetch_multiple_answers(answer)
		answers = []
			#multilpe_ans format example: "[\"Black\", \"White\", \"Blue\"]"
		answer.multiple_ans.split(%r{"\s*}).each do |ans|
			if ans != ", " && ans != "[" && ans != "]"
				answers.push(ans)
			end
		end
		answers
	end

	def get_multiple_answer_hash(options, multi_answers)
		answer_hash = {}
		options.each do |option|
			answer_hash.store("#{option.answer}", 0)
		end
		multi_answers.each do |answer|
			answers = fetch_multiple_answers(answer)
			answers.each do |answer|
				answer_hash["#{answer}"] += 1
			end
		end
		answer_hash
	end

	def display_category(question)
		if question.subjective?
			"Subjective"
		elsif question.multiple_choice?
			"Multiple Choice"
	 	else
			"Multiple Answer"
		end
	end

end
