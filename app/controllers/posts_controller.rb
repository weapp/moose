class PostsController < ApplicationController

  load_and_authorize_resource :user, except: :dashboard
  load_and_authorize_resource :post, :through => :user, except: :dashboard
  load_and_authorize_resource :post, only: :dashboard

  respond_to :html, :json

  # GET /posts
  # GET /posts.json
  def index
    set_tab :all
    respond_with(@posts)
  end

  def dashboard
    set_tab :all
    respond_with(@posts)
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    respond_with(@post)
  end

  # GET /posts/new
  # GET /posts/new.json
  def new
    respond_with(@post)
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post.user = current_user unless params[:post][:user_id].present?
    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render json: @post, status: :created, location: @post }
      else
        format.html { render action: "new" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /posts/1
  # PUT /posts/1.json
  def update
    params[:post][:tag_ids] ||= []
    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy

    respond_to do |format|
      format.html { redirect_to posts_url }
      format.json { head :no_content }
    end
  end

  def tag
    set_tab params[:tag]
    @posts = @posts.tagged(params[:tag])
    render 'index'
  end
end
