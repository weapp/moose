class UsersController < ApplicationController
  load_and_authorize_resource
  respond_to :html, :json

  def show
    set_tab :all
    respond_with(@user)
  end 
end
