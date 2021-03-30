class CreateMembers < ActiveRecord::Migration[6.1]
  def change
    create_table :members do |t|

      t.integer :user_profile_id
      t.integer :committee_id
      t.string :member_position

      t.index [:user_profile_id, :committee_id], unique: true

      t.timestamps
    end

    add_foreign_key :members, :committees
    add_foreign_key :members, :user_profiles

  end
end
