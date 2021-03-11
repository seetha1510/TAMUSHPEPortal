# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_account!

  def index
    redirect_to(show_path) if account_signed_in?
  end

  def show
    redirect_to(new_user_profile_path) unless UserProfile.exists?(user_id: User.get_current_user(current_account).id)
  end

  def new; end

  def create; end

  def edit; end

  def update; end

  def destory; end

  def test; end

  def setting; end
end
