# frozen_string_literal: true

class UserProfilesController < ApplicationController
  before_action :authenticate_account!
  helper_method :industries

  def index
    @industries = industries
    @user_profiles = UserProfile.joins(:user).select('user_profiles.*,users.approved_status').where('users.approved_status').where.not('users.admin_status').order('users.created_at')
    @user_profiles = @user_profiles.where.not(recruiter: true).or(@user_profiles.where(recruiter: nil))
    search_type = params[:search_type]
    search_word = params[:search_word]
    @eBoardPositions = ["President","Vice President","Secretary","Treasurer","Dir. of External Affairs","Dir. of Internal Affairs","Dir. of Academic Development","Dir. of Public Relations","Dir. of Technical Affairs"]

    if (search_word && search_word != '') ||(search_type == 'Industry')
      if search_type == 'First Name'
        @user_profiles = @user_profiles.where('user_first_name LIKE ?',
                                              "%#{search_word.downcase}%")
      end
      if search_type == 'Last Name'
        @user_profiles = @user_profiles.where('user_last_name LIKE ?',
                                              "%#{search_word.downcase}%")
      end
      if search_type == 'Employer'
        @user_profiles = UserProfile.joins(:employers).where('lower(employers.employer_name) LIKE ?',
                                                             "%#{search_word.downcase}%")
      end
      if search_type == 'School'
        @user_profiles = UserProfile.joins(:schools).where('lower(schools.school_name) LIKE ?',
                                                           "%#{search_word.downcase}%")
      end
      if search_type == 'Field of Study'
        @user_profiles = UserProfile.joins(:students).where('lower(students.student_field_of_study) LIKE ?',
                                                            "%#{search_word.downcase}%")
      end
      if search_type == 'Committee Name'

        @user_profiles = UserProfile.joins(:committees).where('lower(committees.committee_name) LIKE ?',
                                                              "%#{search_word.downcase}%")
      end
      if search_type == 'Industry'
        search_word = params[:select_word]
        @user_profiles = @user_profiles.where('lower(user_industry) LIKE ?',
                                              "%#{search_word.downcase}%")
      end
      if search_type == 'Position Title'
        @user_profiles = UserProfile.joins(:employees).where('lower(employees.employee_position) LIKE ?',
                                                             "%#{search_word.downcase}%")
      end
      ## add more
    end

    # Handles Filters for Search
    @user_profiles_recruiters = []
    @user_profiles_members = []
    @user_profiles_alumni = []
    @user_profiles_external = []
    @all_filters = []
    if params[:recruiter_filter]
      @user_profiles_recruiters = @user_profiles.where("recruiter")
      @all_filters += @user_profiles_recruiters
    end

    if params[:alumni_filter]
      @user_profiles_alumni = @user_profiles.where("user_current_member_status").where(user_membership: nil).or(@user_profiles.where(user_membership: "TAMU SHPE Alumni"))
      @all_filters += @user_profiles_alumni
    end

    if params[:member_filter]
      @user_profiles_members = @user_profiles.where.not("user_current_member_status").where.not("recruiter").where(user_membership: nil).or(@user_profiles.where(user_membership: "TAMU SHPE Member"))
      @all_filters += @user_profiles_members
    end

    if params[:external_filter]
      @user_profiles_external = @user_profiles.where("external_member").or(@user_profiles.where.not(user_membership: "TAMU SHPE Member").where.not(user_membership: "TAMU SHPE Alumni"))
      @all_filters += @user_profiles_external
    end
    
    if params[:recruiter_filter] || params[:alumni_filter] || params[:member_filter] || params[:external_filter]
      @user_profiles = Kaminari.paginate_array(@all_filters.uniq)
    end
    @user_profiles = @user_profiles.page params[:page]
  end

  def show
    @user_profile = UserProfile.find(params[:id])
    @facebook_url = @user_profile.user_facebook_profile_url
    @instagram_url = @user_profile.user_instagram_profile_url
    @linkedin_url = @user_profile.user_linkedin_profile_url
    @portfolio_url = @user_profile.user_portfolio_url
    @employees = Employee.where(user_profile_id: params[:id])
    @students = Student.where(user_profile_id: params[:id])
    @true_email = User.find(UserProfile.find(params[:id]).user_id).user_email
    @eBoardPositions = ["President","Vice President","Secretary","Treasurer","Dir. of External Affairs","Dir. of Internal Affairs","Dir. of Academic Development","Dir. of Public Relations","Dir. of Technical Affairs"]

    @email = if @user_profile.user_display_email_status
               '*************'
             else
               @true_email
             end
    @membership = if @user_profile.user_membership
                    @user_profile.user_membership
                  elsif @user_profile.user_current_member_status
                    'Alumni'
                  elsif @user_profile.external_member
                    'External Member'
                  else
                    'Current Member'
                  end
  end

  def new
    @user_profile = UserProfile.new
    @industries = industries
    @membership_types = membership_types
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
                                    user_industry: @form_params[:user_industry],
                                    recruiter: @form_params[:recruiter],
                                    external_member: @form_params[:external_member],
                                    user_membership: @form_params[:user_membership])

    if @user_profile.save && @user_profile.valid?
      UserMailer.with(user: @user).new_user_email.deliver_later
      @is_on_approved_list = ApprovedEmail.where(email: @user.user_email).length.positive?
      if @user.approved_status
        redirect_to(show_path) and return
      elsif @is_on_approved_list
        @user.update(approved_status: true)
        redirect_to(show_path) and return
      else
        redirect_to approval_path and return
      end
    else
      @industries = industries
      @membership_types = membership_types

      render 'new'
    end
  end

  def edit
    @user_profile = UserProfile.find(params[:id])
    @industries = industries
    @membership_types = membership_types
  end

  def update
    @user_profile = UserProfile.find(params[:id])
    if @user_profile.update(user_profile_params)
      redirect_to(user_profile_path(User.get_current_user_profile(current_account).id))
    else
      @industries = industries
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
      redirect_to root_url, notice: 'Something is wrong...'
    end
  end

  def membership_types
    ['TAMU SHPE Member', 'TAMU SHPE Alumni', 'Company Rep.','Region 5 Team', 'National Team',
      'SHPE Houston Professional'] + 
     ['SHPE OU' ,'SHPE Rice', 'SHPE UH', 'SHPE UNT', 'SHPE UTA', 'UT SHPE',
      'SHPE LSU', 'SHPE UOFA', 'TAMUCC SHPE', 'UTEP SHPE', 'SHPE UTSA', 'SHPE STMU', 'TTU SHPE', 'SHPE TXST', 'SHPE SMU'
     ].sort
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

  private

  def user_profile_params
    params.require(:user_profile).permit(:user_first_name, :user_last_name, :user_id,
                                         :user_display_email_status, :user_current_member_status,
                                         :user_facebook_profile_url, :user_instagram_profile_url,
                                         :user_linkedin_profile_url, :user_graduating_year,
                                         :user_about_me_description, :user_phone_number,
                                         :user_profile_picture, :user_portfolio_url,
                                         :user_industry, :recruiter,:external_member, :user_membership)
  end
end

def capitalize_name(user_profile)
  user_profile.user_first_name.humanize.gsub(/\b('?[a-z])/) { $1.capitalize } + " " + user_profile.user_last_name.humanize.gsub(/\b('?[a-z])/) { $1.capitalize }
end