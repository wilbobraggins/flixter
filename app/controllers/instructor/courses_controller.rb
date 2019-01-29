class Instructor::CoursesController < ApplicationController
  before_action :authenticate_user!
  before_action :require_authorized_for_current_course, only: [:show, :destroy]

  def new
    if current_user.admin?
      @course = Course.new
    else
      render plain: "Unauthorized", status: :unauthorized
    end
  end

  def create
    @course = current_user.courses.create(course_params)
    if @course.valid?
      redirect_to instructor_course_path(@course)
    else
      render :new, status: :unprocessable_entity
    end  
  end

  def show
    @section = Section.new
    @lesson = Lesson.new
    @course = Course.new
  end

  def destroy
    if current_course.user != current_user
      render plain: "Unauthorized", status: :unauthorized
    else
      Course.find(params[:id]).destroy
        #flash[:success] = "Course deleted."
        redirect_to instructor_course_path(@course)
    end
  end

  private

  def require_authorized_for_current_course
    if current_course.user != current_user
      render plain: "Unauthorized", status: :unauthorized
    end
  end

  helper_method :current_course
  def current_course
    @current_course ||= Course.find(params[:id])
  end

  def course_params
    params.require(:course).permit(:title, :description, :cost, :image,)
  end
end
