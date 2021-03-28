class PagesController < ApplicationController
    def help
        @admins = User.all.joins(:user_profile).select("users.*,user_profiles.*").where(:admin_status => true)
    end
end
