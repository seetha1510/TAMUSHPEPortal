# frozen_string_literal: true

class UserProfilesController < ApplicationController
  before_action :authenticate_account!
  
  def index
    @user_profiles = UserProfile.all
    return unless params[:search_by_first_name] && params[:search_by_first_name] != ''

    @user_profiles = @user_profiles.where('user_first_name LIKE ?',
                                          "%#{params[:search_by_first_name].downcase}%")
  end

  def show
    # @user_profile = UserProfile.find(params[:id])
    # if(@user_profile.user_display_email_status)
    #     @email = "*************"
    # else
    #     @email = @user_profile.user_email
    # end
    # if(@user_profile.user_current_member_status)
    #     @membership = "Current Member"
    # else
    #     @membership = "Alumni"
    # end
  end

  def new
    @user_profile = UserProfile.new
  end

  def create
    #@user_profile = UserProfile.new(user_profile_params)
    @form_params = params[:user_profile]
    @user_id = User.get_current_user(current_account).id
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
                                    user_portfolio_url: @form_params[:user_portfolio_url]
                                    )
    if @user_profile.save && @user_profile.valid?
      redirect_to(show_path)
    else
      render 'new' 
    end
  end

  def edit
    @user_profile = UserProfile.find(params[:id])
  end

  def update
    @user_profile = UserProfile.find(params[:id])
    if @user_profile.update(user_profile_params)
      redirect_to(employee_path(User.get_current_user_profile(current_account).id))
    else
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

  private

  def user_profile_params
    params.require(:user_profile).permit(:user_first_name, :user_last_name, :user_id,
                                         :user_display_email_status, :user_current_member_status,
                                         :user_facebook_profile_url, :user_instagram_profile_url,
                                         :user_linkedin_profile_url, :user_graduating_year,
                                         :user_about_me_description, :user_phone_number,
                                         :user_profile_picture, :user_portfolio_url)
  end
end
