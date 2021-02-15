class UserProfilesController < ApplicationController

    def index
        @user_profiles = UserProfile.all
        if params[:search_by_first_name] && params[:search_by_first_name] != ""
            @user_profiles = @user_profiles.where("user_first_name LIKE ?",
             "%" + params[:search_by_first_name].downcase + "%" )
        end
    end

    def show
        @user_profile = UserProfile.find(params[:id])
        if(@user_profile.user_display_email_status)
            @email = "*************"
        else
            @email = @user_profile.user_email
        end
        if(@user_profile.user_current_member_status)
            @membership = "Current Member"
        else
            @membership = "Alumni"
        end

    end

    def new
        @user_profile = UserProfile.new
    end

    def create
        @user_profile = UserProfile.new(user_profile_params)
        if @user_profile.save
            redirect_to(user_profiles_path)
        else
            render('new')
        end

    end

    def edit
        @user_profile = UserProfile.find(params[:id])
    end

    def update
        @user_profile = UserProfile.find(params[:id])
        if @user_profile.update(user_profile_params)
            redirect_to (user_profile_path(@user_profile))
        else
            render('edit')
        end
    end

    def destory
    end
    private 
        def user_profile_params
            params.require(:user_profile).permit(:user_first_name,:user_last_name,:user_email,:user_display_email_status,:user_current_member_status,:user_facebook_profile_url,:user_instagram_profile_url,:user_linkedin_profile_url,:user_graduating_year,:user_about_me_description,:user_phone_number,:user_profile_picture_url)
        end
end
