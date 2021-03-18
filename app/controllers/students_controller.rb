class StudentsController < ApplicationController
    def index
        @students = Student.all 
    end

    def show
    end
  
    def new
        @student = Student.new
    end
  
    def create
        @form_params = params[:student]

        @user_profile_id = User.get_current_user_profile(current_account).id

        @school_name = @form_params[:school_name]
        @school_object = School.where(school_name: @school_name).first

        @degree_start_date = Date.new(@form_params["degree_start_date(1i)"].to_i, @form_params["degree_start_date(2i)"].to_i)
        if @form_params[:current_degree] == "1"
            @degree_end_date = nil
        else
            @degree_end_date = Date.new(@form_params["degree_end_date(1i)"].to_i, @form_params["degree_end_date(2i)"].to_i)
        end

        if @school_object.nil?
            @school_object = School.create(school_name: @school_name)
        end
        
        @student = Student.new(user_profile_id: @user_profile_id,
                                    school_id: @school_object.id, student_degree: @form_params[:student_degree],
                                    student_field_of_study: @form_params[:student_field_of_study], 
                                    degree_start_date: @degree_start_date, degree_end_date: @degree_end_date)
        if @student.save
            redirect_to user_profile_path(User.get_current_user_profile(current_account).id)
        else
            puts "\n\n\n\n\n\n"
            render 'new'
        end
    end
  
    def edit
        @student = Student.find(params[:id])
        @school_name = School.find(@student.school_id).school_name
        @edit_student = Student.find(params[:id])
        @student_degree = @edit_student.student_degree
        @current_degree = @edit_student.degree_end_date == nil
    end
  
    def update
        @form_params = params[:student]
        @student = Student.find(params[:id])
        @user_profile_id = User.get_current_user_profile(current_account).id

        @school_name = @form_params[:school_name]
        @school_object = School.where(school_name: @school_name).first

        @degree_start_date = Date.new(@form_params["degree_start_date(1i)"].to_i, @form_params["degree_start_date(2i)"].to_i)
        if @form_params[:current_degree] == "1"
            @degree_end_date = nil
        else
            @degree_end_date = Date.new(@form_params["degree_end_date(1i)"].to_i, @form_params["degree_end_date(2i)"].to_i)
        end

        # @student = Student.find(params[:id])
        # @existing_school = School.find(@student.school_id)
        # if @school_name != @existing_school.school_name
        #     @students_with_same_school = Student.where(school_id: @existing_school.id)
        #     if @students_with_same_school.length() == 0
        #         @existing_school.destroy
        #     end
        # end

        if @school_object.nil?
            @school_object = School.create(school_name: @school_name)
        end
        
        if @student.update(user_profile_id: @user_profile_id,
                                    school_id: @school_object.id, student_degree: @form_params[:student_degree],
                                    student_field_of_study: @form_params[:student_field_of_study], 
                                    degree_start_date: @degree_start_date, degree_end_date: @degree_end_date)
            redirect_to user_profile_path(User.get_current_user_profile(current_account).id)
        else
            render 'edit'
        end
    end
  
    def destroy
        @student = Student.find(params[:id])
        @school = School.find(@student.school_id)
        @student.destroy

        @students_with_same_school = Student.where(school_id: @school.id)
        if @students_with_same_school.length() == 0
            @school.destroy
        end

        redirect_to user_profile_path(User.get_current_user_profile(current_account).id)
    end
end
