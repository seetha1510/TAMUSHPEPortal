# frozen_string_literal: true

class AdminsController < ApplicationController
  before_action :authenticate_account!

  helper_method :industries

  def home; end

  def committees
    @committees = Committee.all
    @approved_users = get_valid_users()
  end

  def committees_new
    @committee_name = params[:committee_name]
    @committee = Committee.new(committee_name: @committee_name)
    @committee.save

    redirect_to admin_committees_path 
  end

  def committees_add_member
    @committee_id = params[:id]
    @member_name = params[:member_name]
    @member_position = params[:member_position]


    @index = @member_name.index('-')
    @email = @member_name[@index+2..-1]
    @user_profile_id = UserProfile.find_by(user_id: User.find_by(user_email: @email).id).id

    @member = Member.new(user_profile_id: @user_profile_id, committee_id: @committee_id, member_position: @member_position)
    @member.save

    redirect_to admin_committees_path
  end

  def committees_remove_member
    @member_id = params[:id]
    @member = Member.find(@member_id)
    @member.destroy

    redirect_to admin_committees_path
  end

  def requests
    @accounts = []
    @requested_users = User.where(approved_status: false)
    @requested_users.each do |user|
      @user_profile = UserProfile.find_by(user_id: user.id)
      if @user_profile
        @accounts.append(user)
      end
    end
    @accounts_requested = @accounts 
  end

  def request_approve
    @user_id = params[:id]

    @user = User.find(@user_id)
    @user.update(approved_status: true)

    redirect_to admin_account_requests_path
  end

  def request_deny
    @user_id = params[:id]

    @user = User.find(@user_id)
    @account = Account.find_by(email: @user.user_email)
    @user_profile = UserProfile.find_by(user_id: @user_id)

    @user_profile.destroy
    @user.destroy
    @account.destroy

    redirect_to admin_account_requests_path
  end

  def emails
    @emails = ApprovedEmail.all
  end

  def email_add
    @email = params[:email]
    @approved_email = ApprovedEmail.new(email: @email)
    @approved_email.save

    redirect_to admin_preapproved_emails_path
  end

  def email_remove
    @email_id = params[:id]

    @email = ApprovedEmail.find(@email_id)
    @email.destroy

    redirect_to admin_preapproved_emails_path
  end

  def approved
    @approved_users = User.where(approved_status: true)
  end

  def approved_view
    @user = User.find(params[:id])
    @user_profile = @user.user_profile
    @employees = Employee.where(user_profile_id: @user_profile.id)
    @students = Student.where(user_profile_id: @user_profile.id)
  end

  def approved_edit
    @user = User.find(params[:id])

    @user_profile = @user.user_profile
    @user_profile_did_update = @user_profile.update(
      user_first_name: params[:user_first_name],
      user_last_name: params[:user_last_name],
      user_display_email_status: params[:user_display_email_status],
      user_current_member_status: params[:user_current_member_status],
      user_facebook_profile_url: params[:user_facebook_profile_url],
      user_instagram_profile_url: params[:user_instagram_profile_url],
      user_linkedin_profile_url: params[:user_linkedin_profile_url],
      user_graduating_year: params[:user_graduating_year],
      user_about_me_description: params[:user_about_me_description],
      user_phone_number: params[:user_phone_number],
      user_portfolio_url: params[:user_portfolio_url]
    )

    @employees = Employee.where(user_profile_id: @user_profile.id)
    @employees_did_update = true
    @employees.each.with_index(1) do |employee, index|
      @employee_attr = get_this_employees_attributes(params, index)

      @employer_object = Employer.where(employer_name: @employee_attr['employer_name']).first
      @employer_object = Employer.create(employer_name: @employee_attr['employer_name']) if @employer_object.nil?

      @employees_did_update = employee.update(employer_id: @employer_object.id,
                                              employee_position: @employee_attr['employee_position'],
                                              position_start_date: @employee_attr['start_date'],
                                              position_end_date: @employee_attr['end_date'],
                                              position_location_state: @employee_attr['position_state'],
                                              position_location_city: @employee_attr['position_city'])

      break unless @employees_did_update
    end

    @students = Student.where(user_profile_id: @user_profile.id)
    @students_did_update = true
    @students.each.with_index(1) do |student, index|
      @student_attr = get_this_students_attributes(params, index)

      @school_object = School.where(school_name: @student_attr['school_name']).first
      @school_object = School.create(school_name: @student_attr['school_name']) if @school_object.nil?

      @students_did_update = student.update(school_id: @school_object.id,
                                            student_degree: @student_attr['student_degree'],
                                            student_field_of_study: @student_attr['student_field_of_study'],
                                            degree_start_date: @student_attr['start_date'],
                                            degree_end_date: @student_attr['end_date'])

      break unless @students_did_update
    end

    if @user_profile_did_update && @employees_did_update && @students_did_update
      redirect_to admin_approved_users_path
    else
      render :approved_view
    end
  end

  def approved_delete
    @user = User.find(params[:id])
    @user_profile = @user.user_profile
    @employees = Employee.where(user_profile_id: @user_profile.id)
    @students = Student.where(user_profile_id: @user_profile.id)
    @profile_pic = User.get_current_user_profile(current_account).user_profile_picture
    @account = Account.find_by(email: @user.user_email)

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

    @profile_pic.purge
    @user_profile.destroy
    @user.destroy
    @account.destroy

    redirect_to admin_approved_users_path
  end

  def get_this_employees_attributes(params, index)
    @start_date = Date.new(params["position_start_date_#{index}(1i)".to_sym].to_i,
                           params["position_start_date_#{index}(2i)".to_sym].to_i)
    @end_date = if params["current_role_#{index}".to_sym] == '1'
                  nil
                else
                  Date.new(params["position_end_date_#{index}(1i)".to_sym].to_i,
                           params["position_end_date_#{index}(2i)".to_sym].to_i)
                end

    {
      'employer_name' => params["employer_name_#{index}".to_sym],
      'employee_position' => params["employee_position_#{index}".to_sym],
      'start_date' => @start_date,
      'end_date' => @end_date,
      'position_city' => params["position_location_city_#{index}".to_sym],
      'position_state' => params["position_location_state_#{index}".to_sym]
    }
  end

  def get_this_students_attributes(params, index)
    @start_date = Date.new(params["degree_start_date_#{index}(1i)".to_sym].to_i,
                           params["degree_start_date_#{index}(2i)".to_sym].to_i)
    @end_date = if params["current_study_#{index}".to_sym] == '1'
                  nil
                else
                  Date.new(params["degree_end_date_#{index}(1i)".to_sym].to_i,
                           params["degree_end_date_#{index}(2i)".to_sym].to_i)
                end

    {
      'school_name' => params["school_name_#{index}".to_sym],
      'student_degree' => params["student_degree_#{index}".to_sym],
      'start_date' => @start_date,
      'end_date' => @end_date,
      'student_field_of_study' => params["student_field_of_study_#{index}".to_sym]
    }
  end

  def get_valid_users
    @approved_users = []
    @users = User.where(approved_status: true)
    @users.each do |user|
      @user_profile = UserProfile.find_by(user_id: user.id)
      if @user_profile
        @first = @user_profile.user_first_name
        @last = @user_profile.user_last_name
        @approved_users.append("#{@last}, #{@first} - #{user.user_email}")
      end
    end

    @approved_users.sort
  end
end
