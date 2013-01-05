class PagesController < ApplicationController
  def index
    if current_user
      render
    else
      DeviseController::Sessions.new
      #render 'devise/sessions/new'
    end
  end
end
