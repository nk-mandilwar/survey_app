class RemoveColFromQuestion < ActiveRecord::Migration
  def change
    remove_column :questions, :no_of_options, :string
  end
end
