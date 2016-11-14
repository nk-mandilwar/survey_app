class AddColToSurvey < ActiveRecord::Migration
  def change
  	add_column :surveys, :is_template, :boolean
  	add_column :surveys, :is_published, :boolean
  	add_column :surveys, :cloned_from, :integer
  end
end
