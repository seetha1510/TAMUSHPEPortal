class CreateUserProfiles < ActiveRecord::Migration[6.1]
  def change
    create_table :user_profiles, id: false do |t|

      t.integer :user_id, primary_key: true, index: true, unique: true, null: false
      t.string :user_email
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

      #profile picture may need to be url to hosted image
      t.string :user_profile_picture_url

      t.timestamps
    end

    #creates the fk. user_email in this table is FK for user_email attribute in users table
    add_foreign_key :user_profiles, :users, column: :user_email, primary_key: :user_profile_picture_url

  end
end