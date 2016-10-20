class AddColToAnswer < ActiveRecord::Migration
  def change
    add_column :answers, :multiple_ans, :string
  end
end
