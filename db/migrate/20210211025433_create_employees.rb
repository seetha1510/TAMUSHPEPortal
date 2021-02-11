class CreateEmployees < ActiveRecord::Migration[6.1]
  def change
    create_table :employees, id: false do |t|

      #composite primary key
      #since there could be many past employers for a user
      t.integer :user_id, index: true, null: false
      t.integer :employer_id, index: true, null: false
      t.string :employee_position

      t.timestamps
    end

    #creates the fks. user_id in this table is FK for user_id attribute in user_profiles table
    add_foreign_key :employees, :user_profiles, column: :user_id, primary_key: :user_id
    add_foreign_key :employees, :employers, column: :employer_id, primary_key: :employer_id

    #have to add primary keys here because rails doesnt allow composite keys syntatically
    execute "ALTER TABLE employees ADD PRIMARY KEY (user_id, employer_id);"

  end
end