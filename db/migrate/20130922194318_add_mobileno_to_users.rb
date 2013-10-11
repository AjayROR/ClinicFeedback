class AddMobilenoToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :mobile_no, :string
  end

  def self.down
  	remove_column :users, :mobile_no
  end
end
