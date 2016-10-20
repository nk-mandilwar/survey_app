class RemoveColFromSurveyAnswer < ActiveRecord::Migration
  def change
  	remove_column :survey_answers, :answer, :string
  	remove_reference :survey_answers, :question, index: true, foreign_key: true
  end
end
