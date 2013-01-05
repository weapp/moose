class TagsController < ApplicationController
  load_and_authorize_resource
  #load_and_authorize_resource :tag, :through => :user


  respond_to :html, :json

  # GET /tags
  # GET /tags.json
  def index
    @tags = @tags.uniq
    respond_with(@tags)
  end

  # GET /tags/1
  # GET /tags/1.json
  def show
    set_tab @tag.tag
    respond_with(@tag)
  end

  # GET /tags/new
  # GET /tags/new.json
  def new
    respond_with(@tag)
  end

  # GET /tags/1/edit
  def edit
  end

  # POST /tags
  # POST /tags.json
  def create
    respond_to do |format|
      if @tag.save
        format.html { redirect_to @tag, notice: 'Tag was successfully created.' }
        format.json { render json: @tag, status: :created, location: @tag }
      else
        format.html { render action: "new" }
        format.json { render json: @tag.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /tags/1
  # PUT /tags/1.json
  def update
    respond_to do |format|
      if @tag.update_attributes(params[:tag])
        format.html { redirect_to @tag, notice: 'Tag was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @tag.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tags/1
  # DELETE /tags/1.json
  def destroy
    @tag.destroy

    respond_to do |format|
      format.html { redirect_to tags_url }
      format.json { head :no_content }
    end
  end
end
