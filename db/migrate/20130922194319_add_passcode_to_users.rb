class AddPasscodeToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :passcode, :string
  end

  def self.down
  	remove_column :users, :passcode
  end
end
