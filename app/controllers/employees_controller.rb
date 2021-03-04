# frozen_string_literal: true

class EmployeesController < ApplicationController
  def index
    @employees = Employee.all
  end

  def show
    @user_profile = UserProfile.find(params[:id])
    @employees = Employee.where(user_profile_id: params[:id])
    @true_email = User.find(UserProfile.find(params[:id]).user_id).user_email

    @email = if @user_profile.user_display_email_status
               '*************'
             else
                User.get_current_user(current_account).user_email
             end
    @membership = if @user_profile.user_current_member_status
                    'Current Member'
                  else
                    'Alumni'
                  end
  end

  def new
    @employee = Employee.new
  end

  def create
    @form_params = params[:employee]

    @user_profile_id = User.get_current_user_profile(current_account).id

    @employer_name = @form_params[:employer_name]
    @employer_object = Employer.where(employer_name: @employer_name).first

    if @employer_object
      @employee_object = Employee.new(user_profile_id: @user_profile_id,
                                      employer_id: @employer_object.id, employee_position: @form_params[:employee_position])
      if @employee_object.save
        redirect_to employee_path(User.get_current_user_profile(current_account).id)
      else
        redirect_to new_employee_path
      end
    else
      @new_employer = Employer.new(employer_name: @employer_name)
      if @new_employer.save
        @employee_object = Employee.new(user_profile_id: @user_profile_id,
                                        employer_id: @new_employer.id, employee_position: @form_params[:employee_position])
        if @employee_object.save
          redirect_to employee_path(User.get_current_user_profile(current_account).id)
        else
          redirect_to new_employee_path
        end
      else
        redirect_to new_employee_path
      end
    end
  end

  def edit
    @employees = Employee.find(params[:id])
    @employer_name = Employer.find(@employees.employer_id).employer_name
    @employee_position = Employee.find(params[:id]).employee_position
  end

  def update
    @form_params = params[:employee]
    @employee_object = Employee.find(params[:id])

    # change to session id later
    @user_profile_id = User.get_current_user_profile(current_account).id

    @employer_name = @form_params[:employer_name]
    @employer_object = Employer.where(employer_name: @employer_name).first

    if @employer_object
      if @employee_object.update(user_profile_id: @user_profile_id,
                                 employer_id: @employer_object.id, employee_position: @form_params[:employee_position])
        redirect_to employee_path(User.get_current_user_profile(current_account).id)
      else
        render :edit
      end
    else
      @new_employer = Employer.new(employer_name: @employer_name)
      if @new_employer.save
        if @employee_object.update(user_profile_id: @user_profile_id,
                                   employer_id: @new_employer.id, employee_position: @form_params[:employee_position])
          redirect_to employee_path(User.get_current_user_profile(current_account).id)
        else
          render :edit
        end
      else
        render :edit
      end
    end
  end

  def destory; end
end
