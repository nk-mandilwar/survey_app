class AddColToSurvey < ActiveRecord::Migration
  def change
  	add_column :surveys, :is_template, :boolean
  end
end
