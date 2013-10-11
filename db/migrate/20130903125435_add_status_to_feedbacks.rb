class AddStatusToFeedbacks < ActiveRecord::Migration
  def self.up
    add_column :feedbacks, :status, :boolean, :default => 1  # 1 means status is open.
    
 end

  def self.down
  	remove_column :feedbacks, :status
  end
end