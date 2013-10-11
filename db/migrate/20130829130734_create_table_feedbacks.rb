class CreateTableFeedbacks < ActiveRecord::Migration
    def self.up
     create_table :feedbacks do |t|
         t.integer :rating1
         t.integer :rating2
         t.integer :rating3
         t.integer :rating4
         t.boolean :rating5
         t.integer :rating5a
         t.integer :rating5b
         t.integer :rating6
         t.integer :department_id
         t.text :feedback
         t.string :name
         t.string :email
         t.timestamps
      end
      
    end

    def self.down
  	     drop_table :feedbacks
    end
end
