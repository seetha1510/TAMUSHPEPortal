class AddRecruiterToUserProfile < ActiveRecord::Migration[6.1]
  def change
    add_column :user_profiles, :recruiter, :boolean
  end
end
