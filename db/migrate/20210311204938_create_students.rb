class CreateStudents < ActiveRecord::Migration[6.1]
  def change
    create_table :students do |t|
      t.integer :user_profile_id
      t.integer :school_id
      t.string :student_degree
      t.string :student_field_of_study
      t.datetime :degree_start_date
      t.datetime :degree_end_date

      t.timestamps
    end
    add_foreign_key :students, :user_profiles
    add_foreign_key :students, :schools
  end
end
