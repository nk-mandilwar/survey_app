class AddAndRemoveColFromSurvey < ActiveRecord::Migration
  def change
  	remove_column :surveys, :is_template, :boolean
  	add_column :surveys, :attendee, :string
  end
end
