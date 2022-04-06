# frozen_string_literal: true

class AdminsController < ApplicationController
  before_action :authenticate_account!

  helper_method :industries

  def home; end

  def committees
    @committees = Committee.all
    @approved_users = valid_users_get
    @member = Member.new
    @committee = Committee.new
  end

  def committees_new
    @committee_name = params[:committee_name]
    @committee = Committee.new(committee_name: @committee_name)
    @committee.save

    redirect_to admin_committees_path
  end

  def committees_delete
    @committee_id = params[:id]
    @committee = Committee.find(@committee_id)
    @members = Member.where(committee_id: @committee_id)
    @members.each(&:destroy)
    @committee.destroy

    redirect_to admin_committees_path
  end

  def committees_add_member
    @committee_id = params[:id]
    @member_name = params[:member_name]

    @index = @member_name.index('-')
    @email = @member_name[@index + 2..]
    @user_profile_id = UserProfile.find_by(user_id: User.find_by(user_email: @email).id).id

    @member = Member.new(user_profile_id: @user_profile_id, committee_id: @committee_id)
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
      @accounts.append(user) if @user_profile
    end
    @accounts_requested = @accounts
  end

  def request_approve
    @user_id = params[:id]

    @user = User.find(@user_id)
    @user.update(approved_status: true)
    ApprovedMailer.with(user: @user).approved_email.deliver_later

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
    @members = Member.where(user_profile_id: @user_profile.id)
    @industries = industries
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
      user_portfolio_url: params[:user_portfolio_url],
      user_industry: params[:user_industry]
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

    @members = Member.where(user_profile_id: @user_profile.id)
    @members_did_update = true
    @members.each.with_index(1) do |member, index|
      @member_attr = get_this_members_attributes(params, index)

      @committee_object = Committee.where(committee_name: @member_attr['committee_name']).first
      @committee_object = Committee.create(committee_name: @member_attr['committee_name']) if @committee_object.nil?

      @members_did_update = member.update(committee_id: @committee_object.id)

      break unless @members_did_update
    end

    if @user_profile_did_update && @employees_did_update && @students_did_update && @members_did_update
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

    @members.each(&:destroy)

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

  def get_this_members_attributes(params, index)
    {
      'committee_name' => params["committee_name_#{index}".to_sym]
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

  def email_import
    @num = ApprovedEmail.import(params[:file])
    if @num.nil?
      redirect_to admin_preapproved_emails_path, alert: 'The file uploaded was not of CSV format'
    elsif @num == -1
      redirect_to admin_preapproved_emails_path, alert: 'There was a problem with adding pre-approved emails'
    elsif @num == -2
      redirect_to admin_preapproved_emails_path, alert: "There was a no column with header named 'Email' in the CSV file"
    elsif @num == -3
      redirect_to admin_preapproved_emails_path, alert: 'A file must be choosen before importing'
    else
      redirect_to admin_preapproved_emails_path, notice: "Successfully added #{@num} new Pre-approved Emails"
    end
  end

  def valid_users_get
    @approved_users = []
    @users = User.where(approved_status: true)
    @users.each do |user|
      @user_profile = UserProfile.find_by(user_id: user.id)
      next unless @user_profile

      @first = @user_profile.user_first_name
      @last = @user_profile.user_last_name
      @approved_users.append("#{@last}, #{@first} - #{user.user_email}")
    end

    @approved_users.sort
  end

  def documentation; end
end

def default_profile_pic(id)
  'default' + (id % 6 + 1).to_s + ".png"
end

def send_update_profile_emails
  @user_profiles = UserProfile.joins(:user).select('user_profiles.*,users.approved_status').where('users.approved_status').where.not('users.admin_status').order('users.created_at')


  UserMailer.with(user: user).update_profile.deliver_later
end

def industries
  ['Accounting', 'Aerospace Engineering','Airline/Aviation', 'Alternative Dispute Resolution', 'Alternative Medicine', 'Animation', 'Apparel & Fashion', 'Architectural Engineering',
   'Architecture & Planning', 'Arts & Crafts', 'Automotive', 'Aviation & Aerospace', 'Banking', 'Biological & Agricultural Engineering', 'Biomedical Engineering', 'Biotechnology', 'Broadcast Media',
   'Building Materials', 'Business Supplies & Equipment', 'Capital Markets', 'Chemical Engineering', 'Civic & Social Organization',
   'Civil Engineering', 'Commercial Real Estate', 'Computer & Network Securtiy', 'Computer Engineering', 'Computer Games', 'Computer Hardware',
   'Computer Science', 'Computer Software', 'Construction', 'Consumer Electronics', 'Consumer Goods', 'Consumer Services', 'Cosmetics',
   'Dairy', 'Defense & Space', 'Design', 'E-learning', 'Education Management', 'Electrical & Electronic Manufacturing', 'Electrical Engineering', 'Electronic Systems Engineering', "Electro Marine Engineering",
   'Entertainment', 'Environmental Engineering','Environmental Science', 'Events Services', 'Executive Office', 'Facilities Services', 'Farming', 'Financial Services',
   'Fine Art', 'Fishery', 'Food & Beverages', 'Food Production', 'Fundrasing', 'Furniture', 'Gambling & Casinos', 'Glass, Ceramics & Concrete',
   'Government Administration', 'Government Relations', 'Graphic Design', 'Health, Wellness & Fitness', 'Higher Education', 'Hospital & Health Care',
   'Hospitality', 'Human Resources', 'Import & Export', 'Individual & Family Services', 'Industrial Automation', 'Industrial Distribution', 'Industrial Engineering', 'Information Services',
   'Information Technology & Services', 'Insurance', 'Interdisciplinary Engineering','International Affairs', 'International Trade & Development', 'Internet',
   'Investment Banking', 'Investment Management', 'Judiciary', 'Law Enforcement', 'Law Practice', 'Legal Services', 'Legislative Office',
   'Leisure,  Travel & Tourism', 'Libraries', 'Logistics & Supply Chain', 'Luxury Goods & Jewelry', 'Machinery', 'Management Consulting', "Manufacturing and Mechanical Engineering Technology" ,'Material Science & Engineering',
   'Maritime', 'Market Research', 'Marketing & Advertising', 'Mechanical Engineering', 'Media Production', 'Medical Device',
   'Medical Practice', 'Mental Health Care', 'Military', 'Mining & Metals', 'Mobile Games', 'Motion Pictures & Film', 'Multidisciplinary Engineering','Museums & Institutions',
   'Music', 'Nanotechnology', 'Newspapers', 'Non-profit Organization Management', 'Nuclear Engineering', 'Ocean Engineering', 'Oil & Energy', 'Online Media', 'Outsourcing/Offshoring',
   'Package/Freight Delivery', 'Packaging & Containers', 'Paper & Forest Products', 'Performing Arts', 'Petroleum Engineering', 'Pharmaceuticals', 'Philanthropy',
   'Photography', 'Plastics', 'Political Organization', 'Primary/Secondary Education', 'Printing', 'Professional Training & Coaching',
   'Program Development', 'Public Policy', 'Public Relations & Communications', 'Public Saftey', 'Publishing', 'Railroad Manufacture',
   'Ranching', 'Real Estate', 'Recreational Facilities & Services', 'Religous Institutions', 'Renewables & Environment', 'Research',
   'Restaurants', 'Retail', 'Security & Investigations', 'Semiconductors', 'Shipbuilding', 'Software Engineering','Sporting Goods', 'Sports', 'Staffing & Recruiting',
   'Supermarkets', 'Telecommunications', 'Textiles', 'Think Tanks', 'Tobacco', 'Translation & Localization', 'Transportation/Trucking/Railroad',
   'Utilities', 'Venture Capital & Private Equity', 'Veterinary', 'Warehousing', 'Wholesale', 'Wine & Spirits', 'Wireless', 'Writing & Editing']
end