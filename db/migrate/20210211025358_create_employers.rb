class CreateEmployers < ActiveRecord::Migration[6.1]
  def change
    create_table :employers do |t|

      t.string :employer_name, index: true, unique: true, null: false

      t.timestamps
    end
  end
end