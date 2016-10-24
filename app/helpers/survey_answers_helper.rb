module SurveyAnswersHelper

	def get_answers(answer)
		if(answer.ans != nil)
			answer.ans
		else
			answers = []
			answer.multiple_ans.split(%r{"\s*}).each do |ans|
				if ans != ", " && ans != "[" && ans != "]"
					answers.push(ans)
				end
			end
			render partial: "shared/display_answer", locals: {answers: answers}
		end	
	end
end
