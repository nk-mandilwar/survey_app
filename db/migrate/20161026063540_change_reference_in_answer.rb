class ChangeReferenceInAnswer < ActiveRecord::Migration
  def change
  	add_reference :answers, :feedback, index: true, foreign_key: true
  end
end
