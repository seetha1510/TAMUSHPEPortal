class AdminsController < ActionController::Base
    before_action :authenticate_account!

    def home
        
    end

    def requests
        @accounts_requested = User.where(approved_status: false)
    end

    def request_approve
        @user_id = params[:id]

        @user = User.find(@user_id)
        @user.update(approved_status: true)

        redirect_to admin_account_requests_path
    end

    def request_deny
        @user_id = params[:id]

        @user = User.find(@user_id)
        @account = Account.find_by(email: @user.user_email)
        @user_profile = UserProfile.find_by(user_id: @user_id)

        @user_profile.destroy
        @user.destroy
        @account.destroy

        redirect_to admin_account_requests_path
    end

    def emails
        @emails = ApprovedEmail.all
    end

    def email_add
        @email = params[:email]
        @approvedEmail = ApprovedEmail.new(email: @email)
        @approvedEmail.save

        redirect_to admin_preapproved_emails_path 
    end

    def email_remove
        @email_id = params[:id]

        @email = ApprovedEmail.find(@email_id)
        @email.destroy

        redirect_to admin_preapproved_emails_path
    end

    def approved
        @approved_users = User.where(approved_status: true)
    end

    def approved_view
        @user = User.find(params[:id])
        @user_profile = @user.user_profile
    end

    def approved_edit
        @user = User.find(params[:id])
        @user_profile = @user.user_profile

        if @user_profile.update(user_first_name: params[:user_first_name], 
                             user_last_name: params[:user_last_name])
        
            redirect_to admin_approved_users_path
        else
            render :approved_view
        end
    end

    def approved_delete
        @user = User.find(params[:id])
        @user_profile = @user.user_profile
        @employees = Employee.where(user_profile_id: @user_profile.id)
        @account = Account.find_by(email: @user.user_email)

        @employees.each do |employee|
            @employer = Employer.find(employee.employer_id)
            employee.destroy
            @employee_with_same_employer = Employee.where(employer_id: @employer.id)
            if @employee_with_same_employer.length() == 0
                @employer.destroy
            end
        end

        @user_profile.destroy
        @user.destroy
        @account.destroy

        redirect_to admin_approved_users_path
    end
end