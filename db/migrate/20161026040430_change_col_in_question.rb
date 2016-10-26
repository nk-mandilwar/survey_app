class ChangeColInQuestion < ActiveRecord::Migration
  def change
  	change_column :questions, :category, :integer
  end
end
