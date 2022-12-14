# frozen_string_literal: true

class EmployeesController < ApplicationController
  before_action :authenticate_account!

  # helper_method :industries

  def index
    @employees = Employee.all
  end

  def show
    # @user_profile = UserProfile.find(params[:id])
    # @employees = Employee.where(user_profile_id: params[:id])
    # @true_email = User.find(UserProfile.find(params[:id]).user_id).user_email

    # @email = if @user_profile.user_display_email_status
    #            '*************'
    #          else
    #            User.get_current_user(current_account).user_email
    #          end
    # @membership = if @user_profile.user_current_member_status
    #                 'Current Member'
    #               else
    #                 'Alumni'
    #               end
  end

  def new
    @employee = Employee.new
  end

  def create
    @form_params = params[:employee]

    @user_profile_id = User.get_current_user_profile(current_account).id

    @start_date = Date.new(@form_params['position_start_date(1i)'].to_i, @form_params['position_start_date(2i)'].to_i)
    @end_date = if @form_params[:current_role] == '1'
                  nil
                else
                  Date.new(@form_params['position_end_date(1i)'].to_i, @form_params['position_end_date(2i)'].to_i)
                end

    @employer_name = @form_params[:employer_name]
    @employer_object = Employer.where(employer_name: @form_params[:employer_name]).first

    @employer_object = Employer.create(employer_name: @employer_name) if @employer_object.nil?

    @employee = Employee.new(user_profile_id: @user_profile_id,
                             employer_id: @employer_object.id, employee_position: @form_params[:employee_position],
                             position_start_date: @start_date, position_end_date: @end_date, position_location_state: @form_params[:position_location_state],
                             position_location_city: @form_params[:position_location_city])

    if @employee.save
      redirect_to user_profile_path(User.get_current_user_profile(current_account).id)
    else
      # redirect_to new_employee_path and return
      # @industries = industries
      render 'new'
    end
  end

  def edit
    @employee = Employee.find(params[:id])
    @employer_name = Employer.find(@employee.employer_id).employer_name
    @edit_employee = Employee.find(params[:id])
    @employee_position = @edit_employee.employee_position
    @current_position = @edit_employee.position_end_date.nil?
  end

  def update
    @form_params = params[:employee]
    @employee = Employee.find(params[:id])
    @user_profile_id = User.get_current_user_profile(current_account).id

    @start_date = Date.new(@form_params['position_start_date(1i)'].to_i, @form_params['position_start_date(2i)'].to_i)
    @end_date = if @form_params[:current_role] == '1'
                  nil
                else
                  Date.new(@form_params['position_end_date(1i)'].to_i, @form_params['position_end_date(2i)'].to_i)
                end

    @employer_name = @form_params[:employer_name]
    @employer_object = Employer.where(employer_name: @employer_name).first

    @employee = Employee.find(params[:id])
    @existing_employer = Employer.find(@employee.employer_id)

    @employer_object = Employer.create(employer_name: @employer_name) if @employer_object.nil?

    if @employee.update(user_profile_id: @user_profile_id,
                        employer_id: @employer_object.id, employee_position: @form_params[:employee_position],
                        position_start_date: @start_date, position_end_date: @end_date, position_location_state: @form_params[:position_location_state],
                        position_location_city: @form_params[:position_location_city])
      redirect_to user_profile_path(User.get_current_user_profile(current_account).id)
    else
      render 'edit'
    end

    if @employer_name != @existing_employer.employer_name
      @employee_with_same_employer = Employee.where(employer_id: @existing_employer.id)
      @existing_employer.destroy if @employee_with_same_employer.length.zero?
    end
  end

  def destroy
    @employee = Employee.find(params[:id])
    @employer = Employer.find(@employee.employer_id)
    @employee.destroy

    @employee_with_same_employer = Employee.where(employer_id: @employer.id)
    @employer.destroy if @employee_with_same_employer.length.zero?

    redirect_to user_profile_path(User.get_current_user_profile(current_account).id)
  end

  # def industries
  #   ['Accounting', 'Airline/Aviation', 'Alternative Dispute Resolution', 'Alternative Medicine', 'Animation', 'Apparel & Fashion',
  #    'Architecture & Planning', 'Arts & Crafts', 'Automotive', 'Aviation & Aerospace', 'Banking', 'Biotechnology', 'Broadcast Media',
  #    'Building Materials', 'Business Supplies & Equipment', 'Capital Markets', 'Chemicals', 'Civic & Social Organization',
  #    'Civil Engineering', 'Commercial Real Estate', 'Computer & Network Securtiy', 'Computer Engineering', 'Computer Games', 'Computer Hardware',
  #    'Computer Networking', 'Computer Software', 'Construction', 'Consumer Electronics', 'Consumer Goods', 'Consumer Services', 'Cosmetics',
  #    'Dairy', 'Defense & Space', 'Design', 'E-learning', 'Education Management', 'Electrical & Electronic Manufacturing',
  #    'Entertainment', 'Environmental Science', 'Events Services', 'Executive Office', 'Facilities Services', 'Farming', 'Financial Services',
  #    'Fine Art', 'Fishery', 'Food & Beverages', 'Food Production', 'Fundrasing', 'Furniture', 'Gambling & Casinos', 'Glass, Ceramics & Concrete',
  #    'Government Administration', 'Government Relations', 'Graphic Design', 'Health, Wellness & Fitness', 'Higher Education', 'Hospital & Health Care',
  #    'Hospitality', 'Human Resources', 'Import & Export', 'Individual & Family Services', 'Industrial Automation', 'Information Services',
  #    'Information Technology & Services', 'Insurance', 'International Affairs', 'International Trade & Development', 'Internet',
  #    'Investment Banking', 'Investment Management', 'Judiciary', 'Law Enforcement', 'Law Practice', 'Legal Services', 'Legislative Office',
  #    'Leisure,  Travel & Tourism', 'Libraries', 'Logistics & Supply Chain', 'Luxury Goods & Jewelry', 'Machinery', 'Management Consulting',
  #    'Maritime', 'Market Research', 'Marketing & Advertising', 'Mechanical Or Industrial Engineering', 'Media Production', 'Medical Device',
  #    'Medical Practice', 'Mental Health Care', 'Military', 'Mining & Metals', 'Mobile Games', 'Motion Pictures & Film', 'Museums & Institutions',
  #    'Music', 'Nanotechnology', 'Newspapers', 'Non-profit Organization Management', 'Oil & Energy', 'Online Media', 'Outsourcing/Offshoring',
  #    'Package/Freight Delivery', 'Packaging & Containers', 'Paper & Forest Products', 'Performing Arts', 'Pharmaceuticals', 'Philanthropy',
  #    'Photography', 'Plastics', 'Political Organization', 'Primary/Secondary Education', 'Printing', 'Professional Training & Coaching',
  #    'Program Development', 'Public Policy', 'Public Relations & Communications', 'Public Saftey', 'Publishing', 'Railroad Manufacture',
  #    'Ranching', 'Real Estate', 'Recreational Facilities & Services', 'Religous Institutions', 'Renewables & Environment', 'Research',
  #    'Restaurants', 'Retail', 'Security & Investigations', 'Semiconductors', 'Shipbuilding', 'Sporting Goods', 'Sports', 'Staffing & Recruiting',
  #    'Supermarkets', 'Telecommunications', 'Textiles', 'Think Tanks', 'Tobacco', 'Translation & Localization', 'Transportation/Trucking/Railroad',
  #    'Utilities', 'Venture Capital & Private Equity', 'Veterinary', 'Warehousing', 'Wholesale', 'Wine & Spirits', 'Wireless', 'Writing & Editing']
  # end
end
