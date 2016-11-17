class AddIndexToOption < ActiveRecord::Migration
  def change
  	add_index :options, [:answer, :question_id], unique: true
  end
end
