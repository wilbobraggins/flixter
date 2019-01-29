class StaticPagesController < ApplicationController
  
  def index
    @admin = User.find_by(:admin => true)
  end

  def privacy
  end

  def team
  end

  def career
  end
  
end
