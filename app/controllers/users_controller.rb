class UsersController < ApplicationController
  load_and_authorize_resource
  respond_to :html, :json

  def index
    if params[:role]
      @users = User.with_role(params[:role])
    end
  end

  def show
    set_tab :all
    respond_with(@user)
  end

  def edit
  end

  def update
    if role_id = params[:user][:role_id]
      params[:user].delete(:role_id)
      if current_user.admin?
        @user.role_id = role_id
        @user.save
      end
    end
    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
end
