class GalleriesController < ApplicationController
  skip_before_filter  :verify_authenticity_token, :only => [:create]
  
  def index
    @galleries = Gallery.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @galleries }
    end
  end


  def show
    @gallery = Gallery.find(params[:id])
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @gallery }
    end
  end


  def new
    @gallery = Gallery.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @gallery }
    end
  end


  def edit
    @gallery = Gallery.find(params[:id])
  end


  def create
    @gallery = Gallery.new(params[:gallery])
    # @gallery.user = current_user # set the gallery to be the current user
    if @gallery.save
      json_result = {:id => @gallery.id}.to_json
      logger.debug(json_result);
      render :status => :created, :text => json_result
    else
      json_result = {:document_id => nil}.to_json
      logger.debug(json_result);
      render :status => :unprocessable_entity, :text => json_result
    end
  end


  def update
    @gallery = Gallery.find(params[:id])

    respond_to do |format|
      if @gallery.update_attributes(params[:gallery])
        format.html { redirect_to galleries_url , notice: 'Gallery was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @gallery.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    @gallery = Gallery.find(params[:id])
    @gallery.destroy

    respond_to do |format|
      format.html { redirect_to galleries_url }
      format.json { head :no_content }
    end
  end
end
