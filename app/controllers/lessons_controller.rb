class LessonsController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_user_enrolled?
  def show
  end

  private

  def authenticate_user_enrolled?
    if !current_user.enrolled_in?(current_lesson.section.course)
      redirect_to course_path(current_course), alert: "You Must Enroll to View!"
    end
  end

  helper_method :current_lesson
  def current_lesson
    @current_lesson ||= Lesson.find(params[:id])
  end
end
