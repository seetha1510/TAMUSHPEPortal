# frozen_string_literal: true

class UsersController < ApplicationController
  def index
    redirect_to(show_path) if account_signed_in?
  end

  def show
    redirect_to(new_user_profile_path) unless UserProfile.exists?(user_email: current_account.email)
  end

  def new; end

  def create; end

  def edit; end

  def update; end

  def destory; end

  def test; end

  def setting; end
end
