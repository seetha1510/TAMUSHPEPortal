# frozen_string_literal: true

class UserProfilesController < ApplicationController
  before_action :authenticate_account!
  helper_method :getIndustries  
  
  def index
    @user_profiles = UserProfile.all
    search_type = params[:search_type]
    search_word = params[:search_word]

    if search_word && search_word != ""
      if(search_type == "First Name")
        @user_profiles = @user_profiles.where("user_first_name LIKE ?",
        "%" + search_word.downcase + "%" ).to_set
      end
      if(search_type == "Last Name")
        @user_profiles = @user_profiles.where("user_last_name LIKE ?",
        "%" + search_word.downcase + "%" ).to_set
      end 
      if(search_type == "Employer")   
        @user_profiles = UserProfile.joins(:employers).where("lower(employers.employer_name) LIKE ?",
          "%" + search_word.downcase  + "%" ).to_set
      end 
      if(search_type == "School")
        @user_profiles = UserProfile.joins(:schools).where("lower(schools.school_name) LIKE ?",
          "%" + search_word.downcase  + "%" ).to_set
      end
      if(search_type == "Field of Study")
        @user_profiles = UserProfile.joins(:students).where("lower(students.student_field_of_study) LIKE ?",
          "%" + search_word.downcase  + "%" ).to_set
      end
      if(search_type == "Position Industry")
        @user_profiles = UserProfile.joins(:employees).where("lower(employees.position_industry) LIKE ?",
          "%" + search_word.downcase  + "%" ).to_set
      end
      if(search_type == "Position Title")
        @user_profiles = UserProfile.joins(:employees).where("lower(employees.employee_position) LIKE ?",
          "%" + search_word.downcase  + "%" ).to_set
      end

      
      ## add more
    end
  end

  def show
    @user_profile = UserProfile.find(params[:id])
    @employees = Employee.where(user_profile_id: params[:id])
    @students = Student.where(user_profile_id: params[:id])
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
    @user_profile = UserProfile.new
    @industries = getIndustries
  end

  def create
    @form_params = params[:user_profile]
    @user = User.get_current_user(current_account)
    @user_id = @user.id
      
    @user_profile = UserProfile.new(user_first_name: @form_params[:user_first_name],
                                    user_last_name: @form_params[:user_last_name],
                                    user_id: @user_id,
                                    user_display_email_status: @form_params[:user_display_email_status],
                                    user_current_member_status: @form_params[:user_current_member_status],
                                    user_facebook_profile_url: @form_params[:user_facebook_profile_url],
                                    user_instagram_profile_url: @form_params[:user_instagram_profile_url],
                                    user_linkedin_profile_url: @form_params[:user_linkedin_profile_url],
                                    user_graduating_year: @form_params[:user_graduating_year],
                                    user_about_me_description: @form_params[:user_about_me_description],
                                    user_phone_number: @form_params[:user_phone_number],
                                    user_profile_picture: @form_params[:user_profile_picture],
                                    user_portfolio_url: @form_params[:user_portfolio_url],
                                    user_industry: @form_params[:user_industry]
                                    )
    if @user_profile.save && @user_profile.valid?
      @isOnApprovedList = ApprovedEmail.where(email: @user.user_email).length() > 0
      if @user.approved_status
        redirect_to(show_path) and return
      elsif @isOnApprovedList
        @user.update(approved_status: true)
        redirect_to(show_path) and return
      else
        redirect_to approval_path and return
      end
    else
      @industries = getIndustries
      render 'new' 
    end
  end

  def edit
    @user_profile = UserProfile.find(params[:id])
    @industries = getIndustries
  end

  def update
    @user_profile = UserProfile.find(params[:id])
    if @user_profile.update(user_profile_params)
      redirect_to(user_profile_path(User.get_current_user_profile(current_account).id))
    else
      @industries = getIndustries
      render 'edit'
    end
  end

  def destory; end

  def delete_image
    image = ActiveStorage::Attachment.find(params[:image_id])
    if User.get_current_user_profile(current_account) == image.record
      image.purge
      redirect_back(fallback_location: request.referer)
    else
      redirect_to root_url, notice: "Something is wrong..."
    end
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


  private

  def user_profile_params
    params.require(:user_profile).permit(:user_first_name, :user_last_name, :user_id,
                                         :user_display_email_status, :user_current_member_status,
                                         :user_facebook_profile_url, :user_instagram_profile_url,
                                         :user_linkedin_profile_url, :user_graduating_year,
                                         :user_about_me_description, :user_phone_number,
                                         :user_profile_picture, :user_portfolio_url,
                                         :user_industry)
  end
end
