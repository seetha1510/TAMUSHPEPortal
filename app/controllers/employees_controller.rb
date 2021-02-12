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
        @employee_params = params[:employee]
        @employee = Employee.new(user_id: @employee_params[:user_id], employee_id: @employee_params[:employee_id], employee_position: @employee_params[:employee_position])

        if @employee.save
            redirect_to empoyees_index_path
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
