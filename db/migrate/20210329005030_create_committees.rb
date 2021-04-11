class CreateCommittees < ActiveRecord::Migration[6.1]
  def change
    create_table :committees do |t|

      t.string :committee_name

      t.index :committee_name, unique: true

      t.timestamps
    end
  end
end
