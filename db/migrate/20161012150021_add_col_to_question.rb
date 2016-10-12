class AddColToQuestion < ActiveRecord::Migration
  def change
    add_column :questions, :no_of_options, :integer
  end
end
