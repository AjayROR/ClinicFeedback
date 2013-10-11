class AddAverageRaitingToFeedbacks < ActiveRecord::Migration
  def self.up
    add_column :feedbacks, :average_raiting, :integer, :default => 5
  end
  def self.down
  	remove_column :feedbacks, :average_raiting
  end
end
