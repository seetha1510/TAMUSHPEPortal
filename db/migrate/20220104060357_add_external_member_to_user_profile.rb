class AddExternalMemberToUserProfile < ActiveRecord::Migration[6.1]
  def change
    add_column :user_profiles, :external_member, :boolean
  end
end
