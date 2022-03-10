class AddMemberTypeToUserProfiles < ActiveRecord::Migration[6.1]
  def change
    add_column :user_profiles, :user_membership, :string
  end
end
