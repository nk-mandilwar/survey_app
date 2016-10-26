module FeedbacksHelper

	def get_answers(answer)
		if(answer.ans != nil)
			answer.ans
		else
			answers = []
			#multilpe_ans format example: "[\"Black\", \"White\", \"Blue\"]"
			answer.multiple_ans.split(%r{"\s*}).each do |ans|
				if ans != ", " && ans != "[" && ans != "]"
					answers.push(ans)
				end
			end
			render partial: "shared/display_answer", locals: {answers: answers}
		end	
	end
end
