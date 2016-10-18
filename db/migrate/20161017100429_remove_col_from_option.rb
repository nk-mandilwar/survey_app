class RemoveColFromOption < ActiveRecord::Migration
  def change
    remove_reference :options, :survey, index: true, foreign_key: true
  end
end
