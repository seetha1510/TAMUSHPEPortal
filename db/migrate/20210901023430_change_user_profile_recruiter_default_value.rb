class ChangeUserProfileRecruiterDefaultValue < ActiveRecord::Migration[6.1]
  def change
    change_column_default :user_profiles, :recruiter, false
  end
end
