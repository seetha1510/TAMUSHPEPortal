class CreateCommittees < ActiveRecord::Migration[6.1]
  def change
    create_table :committees do |t|

      t.string :committee_name

      t.timestamps
    end

    add_index :committees, :committee_name, unique: true

  end
end
