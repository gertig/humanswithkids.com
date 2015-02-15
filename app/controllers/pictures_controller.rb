class PicturesController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => :create

  # GET /pictures
  # GET /pictures.json
  def index

    @gallery = Gallery.find(params[:gallery_id])

    @pictures = @gallery.pictures

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @pictures }
    end
  end

  # GET /pictures/1
  # GET /pictures/1.json
  def show
    @picture = Picture.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @picture }
    end
  end

  # GET /pictures/new
  # GET /pictures/new.json
  def new
    @gallery = Gallery.find(params[:gallery_id])
    @picture = @gallery.pictures.build

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @picture }
    end
  end

  # GET /pictures/1/edit
  def edit
    @gallery = Gallery.find(params[:gallery_id])

    @picture = @gallery.pictures.find(params[:id])
    # @picture = Picture.find(params[:id])
  end

  # POST /pictures
  # POST /pictures.json
  def create

    if params[:ios_app] == "1" # using the iOS app to upload a Picture
      # puts "HEEEEY"
      # puts ios_params
      Rails.logger.debug("[debug] : PARAMS: #{ios_params}" );

      @gallery = Gallery.find(ios_params[:gallery_id])
      @picture = @gallery.pictures.build(ios_params)
    else # do things the old way
      Rails.logger.debug("[debug] : PARAMS: #{params[:picture]}" );

      p_attr = clean_params
      Rails.logger.debug("[debug] : #{p_attr}" );
      p_attr[:image] = clean_params[:image].first if clean_params[:image].class == Array
      Rails.logger.debug("[debug] : #{p_attr[:image]}");

      if params[:gallery_id]
        @gallery = Gallery.find(params[:gallery_id])
        @picture = @gallery.pictures.build(p_attr)
      else
        @picture = Picture.new(clean_params)
      end
    end

    if @picture.save
      respond_to do |format|
        format.html {
          render :json => [@picture.to_jq_upload].to_json,
          :content_type => 'text/html',
          :layout => false
        }
        format.json {
          render :json => [@picture.to_jq_upload].to_json
        }
      end
    else
      render :json => [{:error => "custom_failure"}], :status => 304
    end
  end

  # PUT /pictures/1
  # PUT /pictures/1.json
  def update

    @gallery = Gallery.find(params[:gallery_id])

    @picture = @gallery.pictures.find(params[:id])

    respond_to do |format|
      if @picture.update_attributes(clean_params)
        format.html { redirect_to gallery_path(@gallery), notice: 'Picture was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @picture.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pictures/1
  # DELETE /pictures/1.json
  def destroy
    @gallery = Gallery.find(params[:gallery_id])
    @picture = @gallery.pictures.find(params[:id])
    @picture.destroy

    respond_to do |format|
      format.html { redirect_to gallery_pictures_url }
      format.js
    end
  end

  def make_default
    @picture = Picture.find(params[:id])
    @gallery = Gallery.find(params[:gallery_id])

    @gallery.cover = @picture.id
    @gallery.save

    respond_to do |format|
      format.js
    end
  end

  def iosupload
    if params[:ios_app] == "1" # using the iOS app to upload a Picture
      # puts "HEEEEY"
      # puts ios_params
      Rails.logger.debug("[debug] : PARAMS: #{ios_params}" );

      @gallery = Gallery.find(ios_params[:gallery_id])
      @picture = @gallery.pictures.build(ios_params)
    else
      Rails.logger.debug("[debug] : FAILURE TO UPLOAD" );
    end

    render :json => [{:success => "Successful Upload"}], :status => 200
  end

  private

  def ios_params
    params.require(:picture).permit!
  end

  def clean_params
    params.fetch(:picture, {}).permit! #(:description, :gallery_i :crop_x, :crop_y, :crop_w, :crop_h, :gallery_token)
  end
end
