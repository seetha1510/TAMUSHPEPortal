# frozen_string_literal: true

class UsersController < ApplicationController

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

  def destroy
    @user = User.get_current_user(current_account)
    @user_profile = User.get_current_user_profile(current_account)
    @employees = Employee.where(user_profile_id: @user_profile.id)
    
    @employees.each do |employee|
      @employer = Employer.find(employee.employer_id)
      employee.destroy
      @employee_with_same_employer = Employee.where(employer_id: @employer.id)
      if @employee_with_same_employer.length() == 0
        @employer.destroy
      end
    end
    
    @user_profile.destroy
    @user.destroy
    current_account.destroy

    redirect_to root_path
  end

  def test; end

  def setting; end
end
