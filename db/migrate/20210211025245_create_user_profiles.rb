class CreateUserProfiles < ActiveRecord::Migration[6.1]
  def change
    create_table :user_profiles do |t|

      t.integer :user_id
      t.boolean :user_display_email_status
      t.boolean :user_current_member_status
      t.string :user_facebook_profile_url
      t.string :user_instagram_profile_url
      t.string :user_linkedin_profile_url
      t.integer :user_graduating_year
      t.string :user_about_me_description
      t.string :user_phone_number
      t.string :user_first_name
      t.string :user_last_name
      t.string :user_portfolio_url

      t.timestamps  
    end

    add_foreign_key :user_profiles, :users

  end
end