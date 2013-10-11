class AddIdIndexToFeedbacks < ActiveRecord::Migration
  def self.up
  	add_index :feedbacks, :id
  end
  
  def self.down
  	remove_index :feedbacks, :column => :id
  end
end
