class AddIndexToUser < ActiveRecord::Migration
  def change
  	def change
	    add_index :user, :username
	  end
  end
end
