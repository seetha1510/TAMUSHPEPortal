# frozen_string_literal: true

class UsersController < ApplicationController
  def index
    redirect_to(show_path) if account_signed_in?
  end

  def show
    if !UserProfile.exists?(user_id: User.get_current_user(current_account).id)
      redirect_to(new_user_profile_path)
    elsif !User.get_current_user(current_account).approved_status && ApprovedEmail.where(email: User.get_current_user(current_account).user_email).length <= 0
      redirect_to(approval_path)
    end

    # redirect_to(new_user_profile_path) unless UserProfile.exists?(user_id: User.get_current_user(current_account).id)

    # if !User.get_current_user(current_account).approved_status && !(ApprovedEmail.where(email: User.get_current_user(current_account).user_email).length() > 0)
    # redirect_to(approval_path) and return
    # end
  end

  def new; end

  def create; end

  def edit; end

  def update; end

  def destroy
    @user = User.get_current_user(current_account)
    @user_profile = User.get_current_user_profile(current_account)
    @employees = Employee.where(user_profile_id: @user_profile.id)
    @profile_pic = User.get_current_user_profile(current_account).user_profile_picture
    @students = Student.where(user_profile_id: @user_profile.id)
    @members = Member.where(user_profile_id: @user_profile.id)

    @employees.each do |employee|
      @employer = Employer.find(employee.employer_id)
      employee.destroy
      @employee_with_same_employer = Employee.where(employer_id: @employer.id)
      @employer.destroy if @employee_with_same_employer.length.zero?
    end

    @students.each do |student|
      @school = School.find(student.school_id)
      student.destroy
      @students_with_same_school = Student.where(school_id: @school.id)
      @school.destroy if @students_with_same_school.length.zero?
    end

    @members.each do |member|
      member.destroy
    end

    @profile_pic.purge
    @user_profile.destroy
    @user.destroy
    current_account.destroy

    redirect_to root_path
  end

  def test; end

  def setting; end
end
