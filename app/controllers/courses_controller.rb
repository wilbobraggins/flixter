class CoursesController < ApplicationController
  include Admin 

  def index
    @courses = Course.all
  end

  def show
    @course = Course.find(params[:id])
  end
end
