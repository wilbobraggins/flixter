class LessonsController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_user_enrolled? unless :user_admin?
  def show
    current_lesson
  end

  def update
    current_lesson.update_attributes(lesson_params)
    render plain: 'updated'
  end

  private

  def authenticate_user_enrolled?
    if !current_user.enrolled_in?(current_lesson.section.course)
      redirect_to course_path(@current_course), alert: "You Must Enroll to View!"
    end
  end

  def user_admin?
    if current_user.find(params[:admin]) == true
      redirect_to course_path
    end
  end

  helper_method :current_lesson
  def current_lesson
    @current_lesson ||= Lesson.find(params[:id])
  end

  def lesson_params
    params.require(:lesson).permit(:row_order_position)
  end
end
