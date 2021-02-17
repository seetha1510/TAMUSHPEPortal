class CreateUsers < ActiveRecord::Migration[6.1]
  def change

    #create table users not using the automatic id attribute
    create_table :users, id: false do |t|

      #set user_email to be the primary key
      t.string :user_email, primary_key: true, index: true, unique: true, null: false
      t.boolean :admin_status

      #adds created_at and updated_at attributes
      t.timestamps
    end
  end
end