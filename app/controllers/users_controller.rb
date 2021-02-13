class UsersController < ApplicationController

    def index
        @users = User.order("user_email")
    end

    def show
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
