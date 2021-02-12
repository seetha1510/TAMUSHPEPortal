class EmployeesController < ApplicationController

    def index
        @employees = Employee.all
    end

    def show
    end

    def new
        @employee = Employee.new
    end

    def create
        @form_params = params[:employee]
        
        #change to session id later
        @user_id = 1

        @employer_name = @form_params[:employer_name]
        #find the employer_id based on the employer_name
        #if the find returns false then need to add the employer
        #then create the new employee using the new employer_id
        @employer_object = Employer.where(employer_name: @employer_name).first

        if @employer_object
            @employee = Employee.new(user_id: @user_id, employer_id: @employer_object[:employer_id], employee_position: @form_params[:employee_position])
        else
            @new_employer = Employer.new(employer_name: @employer_name)
            if @new_employer.save
                @employee = Employee.new(user_id: @user_id, employer_id: @new_employer[:employer_id], employee_position: @form_params[:employee_position])
            else
                render :new
            end
        end

        if @employee.save
            redirect_to employees_path
        else
            render :new
        end
    end

    def edit
    end

    def update
    end

    def destory
    end
    
end
