class CreateSchools < ActiveRecord::Migration[6.1]
  def change
    create_table :schools do |t|
      t.string :school_name, index: true, unique: true, null: false

      t.timestamps
    end
  end
end
