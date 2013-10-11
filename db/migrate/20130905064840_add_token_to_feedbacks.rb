class AddTokenToFeedbacks < ActiveRecord::Migration
  def self.up
    add_column :feedbacks, :token, :string
     #execute "CREATE SEQUENCE token_token_number_seq START 1001"
  end

  def self.down
  	remove_column :feedbacks, :token
  #	 execute "DROP SEQUENCE token_token_number_seq"
  end
end
