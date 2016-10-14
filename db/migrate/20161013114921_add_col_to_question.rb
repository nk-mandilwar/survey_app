class AddColToQuestion < ActiveRecord::Migration
  def change
  	add_column :questions, :no_of_options, :integer
  	rename_column :questions, :type, :category
  end
end
