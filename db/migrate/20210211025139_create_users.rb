class CreateUsers < ActiveRecord::Migration[6.1]
  def change

    #create table users
    create_table :users do |t|

      t.string :user_email, index: true, unique: true, null: false
      t.boolean :admin_status
      t.boolean :approved_status

      #adds created_at and updated_at attributes
      t.timestamps
    end
  end
end