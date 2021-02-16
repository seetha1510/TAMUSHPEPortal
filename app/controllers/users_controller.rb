class UsersController < ApplicationController

    def index
        
    end

    def show
        if UserProfile.exists?(user_email:current_account.email)
        else
            redirect_to(new_user_profile_path)
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

    def test
    end
    
end
