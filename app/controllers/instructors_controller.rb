class InstructorsController < ApplicationController
rescue_from ActiveRecord::RecordInvalid, with: :instructor_not_found
    def index
        instructors = Instructor.all
        render json: instructors
    end

    def show
        instructor = Instructor.find(params[:id])
        render json: instructor
    end

    def create
        instructor = Instructor.create!(instructor_params)
        render json: instructor, status: :created
    # rescue ActiveRecord::RecordInvalid => invalid
    #     render json: { errors: invalid.record.errors }, status: :unprocessable_entity
        
    end

    def update
        instructor = Instructor.find(params[:id])
        instructor.update!(instructor_params)
        render json: instructor
    end

    def destroy
        instructor = Instructor.find(params[:id])
        instructor.destroy
        head :no_content

    end
    private
    def instructor_params
        params.permit(:name)
    end

    def instructor_not_found(invalid)
        render json: { errors: invalid.record.errors }, status: :unprocessable_entity
    end
end
