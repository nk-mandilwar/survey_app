class CreateFeedbacks < ActiveRecord::Migration
  def change
    create_table :feedbacks do |t|
      t.string :email
      t.references :survey, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
