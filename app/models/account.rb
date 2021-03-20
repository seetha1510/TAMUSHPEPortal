# frozen_string_literal: true

class Account < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :omniauthable, omniauth_providers: [:google_oauth2]
  after_commit :create_in_user_table, on: :create

  def self.from_google(auth)
    create_with(uid: auth[:uid], full_name: auth[:full_name], avatar_url: auth[:avatar_url]).find_or_create_by!(email: auth[:email])
  end

  def create_in_user_table
    @doesUserExist = User.where(user_email: email)
    if @doesUserExist.length() == 0
      User.create!(user_email: email, admin_status: false, approved_status: false)
    end
  end
end
