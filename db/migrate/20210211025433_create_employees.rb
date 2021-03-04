class CreateEmployees < ActiveRecord::Migration[6.1]
  def change
    create_table :employees do |t|

      t.integer :user_profile_id
      t.integer :employer_id
      t.string :employee_position
      
      t.index [:user_profile_id, :employer_id, :employee_position], unique: true, name: "employed"

      t.timestamps
    end

    #creates the fks. user_id in this table is FK for user_id attribute in user_profiles table
    add_foreign_key :employees, :user_profiles
    add_foreign_key :employees, :employers

  end
end