# frozen_string_literal: true

class EmployeesController < ApplicationController
  helper_method :getIndustries
  
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
    @industries = getIndustries
  end

  def create
    @form_params = params[:employee]

    @user_profile_id = User.get_current_user_profile(current_account).id

    @employer_name = @form_params[:employer_name]
    @employer_object = Employer.where(employer_name: @employer_name).first

    @start_date = Date.new(@form_params["position_start_date(1i)"].to_i, @form_params["position_start_date(2i)"].to_i)
    if @form_params[:current_role] == "1"
      @end_date = nil
    else
      @end_date = Date.new(@form_params["position_end_date(1i)"].to_i, @form_params["position_end_date(2i)"].to_i)
    end

    if @employer_object
      @employee_object = Employee.new(user_profile_id: @user_profile_id,
                                      employer_id: @employer_object.id, employee_position: @form_params[:employee_position],
                                      position_start_date: @start_date, position_end_date: @end_date, position_location_state: @form_params[:position_location_state],
                                      position_location_city: @form_params[:position_location_city], position_industry: @form_params[:position_industry])
      if @employee_object.save
        redirect_to employee_path(User.get_current_user_profile(current_account).id)
      else
        redirect_to new_employee_path
      end
    else
      @new_employer = Employer.new(employer_name: @employer_name)
      if @new_employer.save
        @employee_object = Employee.new(user_profile_id: @user_profile_id,
                                        employer_id: @new_employer.id, employee_position: @form_params[:employee_position],
                                        position_start_date: @start_date, position_end_date: @end_date, position_location_state: @form_params[:position_location_state],
                                        position_location_city: @form_params[:position_location_city], position_industry: @form_params[:position_industry])
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
    @edit_employee = Employee.find(params[:id])
    @employee_position = @edit_employee.employee_position
    @current_position = @edit_employee.position_end_date == nil
    @industries = getIndustries
  end

  def update
    @form_params = params[:employee]
    @employee_object = Employee.find(params[:id])

    # change to session id later
    @user_profile_id = User.get_current_user_profile(current_account).id

    @employer_name = @form_params[:employer_name]
    @employer_object = Employer.where(employer_name: @employer_name).first

    @start_date = Date.new(@form_params["position_start_date(1i)"].to_i, @form_params["position_start_date(2i)"].to_i)
    if @form_params[:current_role] == "1"
      @end_date = nil
    else
      @end_date = Date.new(@form_params["position_end_date(1i)"].to_i, @form_params["position_end_date(2i)"].to_i)
    end

    if @employer_object
      if @employee_object.update(user_profile_id: @user_profile_id,
                                 employer_id: @employer_object.id, employee_position: @form_params[:employee_position],
                                 position_start_date: @start_date, position_end_date: @end_date, position_location_state: @form_params[:position_location_state],
                                 position_location_city: @form_params[:position_location_city], position_industry: @form_params[:position_industry])
        redirect_to employee_path(User.get_current_user_profile(current_account).id)
      else
        render :edit
      end
    else
      @new_employer = Employer.new(employer_name: @employer_name)
      if @new_employer.save
        if @employee_object.update(user_profile_id: @user_profile_id,
                                   employer_id: @new_employer.id, employee_position: @form_params[:employee_position],
                                   position_start_date: @start_date, position_end_date: @end_date, position_location_state: @form_params[:position_location_state],
                                   position_location_city: @form_params[:position_location_city], position_industry: @form_params[:position_industry])
          redirect_to employee_path(User.get_current_user_profile(current_account).id)
        else
          render :edit
        end
      else
        render :edit
      end
    end
  end

  def destroy
    @employee = Employee.find(params[:id])
    @employer = Employer.find(@employee.employer_id)
    @employee.destroy

    @employee_with_same_employer = Employee.where(employer_id: @employer.id)
    if @employee_with_same_employer.length() == 0
      @employer.destroy
    end

    redirect_to employee_path(User.get_current_user_profile(current_account).id)
  end

  def getIndustries
    return ["Accounting", "Airline/Aviation", "Alternative Dispute Resolution", "Alternative Medicine", "Animation", "Apparel & Fashion",
            "Architecture & Planning", "Arts & Crafts", "Automotive", "Aviation & Aerospace", "Banking", "Biotechnology", "Broadcast Media",
            "Building Materials", "Business Supplies & Equipment", "Capital Markets", "Chemicals", "Civic & Social Organization",
            "Civil Engineering", "Commercial Real Estate", "Computer & Network Securtiy", "Computer Engineering", "Computer Games", "Computer Hardware",
            "Computer Networking", "Computer Software", "Construction", "Consumer Electronics", "Consumer Goods", "Consumer Services", "Cosmetics",
            "Dairy", "Defense & Space", "Design", "E-learning", "Education Management", "Electrical & Electronic Manufacturing",
            "Entertainment", "Environmental Science", "Events Services", "Executive Office", "Facilities Services", "Farming", "Financial Services",
            "Fine Art", "Fishery", "Food & Beverages", "Food Production", "Fundrasing", "Furniture", "Gambling & Casinos", "Glass, Ceramics & Concrete",
            "Government Administration", "Government Relations", "Graphic Design", "Health, Wellness & Fitness", "Higher Education", "Hospital & Health Care",
            "Hospitality", "Human Resources", "Import & Export", "Individual & Family Services", "Industrial Automation", "Information Services",
            "Information Technology & Services", "Insurance", "International Affairs", "International Trade & Development", "Internet", 
            "Investment Banking", "Investment Management", "Judiciary", "Law Enforcement", "Law Practice", "Legal Services", "Legislative Office",
            "Leisure,  Travel & Tourism", "Libraries", "Logistics & Supply Chain", "Luxury Goods & Jewelry", "Machinery", "Management Consulting",
            "Maritime", "Market Research", "Marketing & Advertising", "Mechanical Or Industrial Engineering", "Media Production", "Medical Device",
            "Medical Practice", "Mental Health Care", "Military", "Mining & Metals", "Mobile Games", "Motion Pictures & Film", "Museums & Institutions",
            "Music", "Nanotechnology", "Newspapers", "Non-profit Organization Management", "Oil & Energy", "Online Media", "Outsourcing/Offshoring",
            "Package/Freight Delivery", "Packaging & Containers", "Paper & Forest Products", "Performing Arts", "Pharmaceuticals", "Philanthropy",
            "Photography", "Plastics", "Political Organization", "Primary/Secondary Education", "Printing", "Professional Training & Coaching",
            "Program Development", "Public Policy", "Public Relations & Communications", "Public Saftey", "Publishing", "Railroad Manufacture",
            "Ranching", "Real Estate", "Recreational Facilities & Services", "Religous Institutions", "Renewables & Environment", "Research",
            "Restaurants", "Retail", "Security & Investigations", "Semiconductors", "Shipbuilding", "Sporting Goods", "Sports", "Staffing & Recruiting",
            "Supermarkets", "Telecommunications", "Textiles", "Think Tanks", "Tobacco", "Translation & Localization", "Transportation/Trucking/Railroad",
            "Utilities", "Venture Capital & Private Equity", "Veterinary", "Warehousing", "Wholesale", "Wine & Spirits", "Wireless", "Writing & Editing"]
  end

end
