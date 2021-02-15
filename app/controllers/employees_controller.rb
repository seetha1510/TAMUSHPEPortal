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
        @employer_object = Employer.where(employer_name: @employer_name).first

        if @employer_object
            @employee_object = Employee.new(user_id: @user_id, employer_id: @employer_object.employer_id, employee_position: @form_params[:employee_position])
        else
            @new_employer = Employer.new(employer_name: @employer_name)
            if @new_employer.save
                @employee_object = Employee.new(user_id: @user_id, employer_id: @new_employer.employer_id, employee_position: @form_params[:employee_position])
            else
                render :new
            end
        end

        if @employee_object.save
            redirect_to employees_path
        else
            render :new
        end
    end

    def edit
        @employee = Employee.find(params[:id])
        @employer_name = Employer.find(@employee.employer_id).employer_name
    end

    def update
        @form_params = params[:employee]
        @employee_object = Employee.find(params[:id])

        #change to session id later
        @user_id = 1

        @employer_name = @form_params[:employer_name]
        @employer_object = Employer.where(employer_name: @employer_name).first

        if @employer_object
            if @employee_object.update(user_id: @user_id, employer_id: @employer_object.employer_id, employee_position: @form_params[:employee_position])
                redirect_to employees_path
            else
                render :edit
            end
        else
            @new_employer = Employer.new(employer_name: @employer_name)
            if @new_employer.save
                if @employee_object.update(user_id: @user_id, employer_id: @new_employer.employer_id, employee_position: @form_params[:employee_position])
                    redirect_to employees_path
                else
                    render :edit
                end
            else
                render :edit
            end
        end
    end

    def destory
    end
    
end
