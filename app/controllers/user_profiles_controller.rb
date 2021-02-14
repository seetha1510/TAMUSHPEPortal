class UserProfilesController < ApplicationController

    def index
        @user_profiles = UserProfile.order("user_first_name")
    end

    def show
        @user_profile = UserProfile.find(params[:user_id])
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
        @user_profile = UserProfile.find(params[:user_id])
    end

    def update
        @user_profile = UserProfile.find(params[:user_id])
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
            params.require(:subject).permit(:name,:visible,:position)
        end
    
end
