class AddIndexToQuestion < ActiveRecord::Migration
  def change
  	add_index :questions, [:query, :survey_id], unique: true
  end
end
