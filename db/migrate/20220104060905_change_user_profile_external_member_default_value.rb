class ChangeUserProfileExternalMemberDefaultValue < ActiveRecord::Migration[6.1]
  def change
    change_column_default :user_profiles, :external_member, false
  end
end
