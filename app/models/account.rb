# frozen_string_literal: true

class Account < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  after_commit :create_in_user_table, on: :create
  after_commit :delete_in_user_table, on: :destroy   

  def create_in_user_table
    User.create!(user_email: email, admin_status: false)
  end

  def delete_in_user_table
    User.destroy(email)
  end
end
