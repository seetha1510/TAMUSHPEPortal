class UserProfilesController < ApplicationController

    def index
    end

    def show
        @user_profiles = UserProfile.all
        if params[:search_by_first_name] && params[:search_by_first_name] != ""
            @user_profiles = @user_profiles.where("user_first_name LIKE ?",
             "%" + params[:search_by_first_name].downcase + "%" )
        end
    end

    def new
    end

    def create
    end

    def edit
    end

    def update
    end

    def destory
    end

end
