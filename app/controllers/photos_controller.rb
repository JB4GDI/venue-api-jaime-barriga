class PhotosController < ApplicationController

  before_action :set_category
  before_action :set_category_photo, only: [:show, :update, :destroy]

  # GET /venueadmins/:venueadmin_id/venues/:venue_id/categorys/:category_id/photos
  def index
    json_response(@category.photos.order(rank: :asc))
  end

  # GET /venueadmins/:venueadmin_id/venues/:venue_id/categorys/:category_id/photos/:id
  def show
    json_response(@photo)
  end

  # POST /venueadmins/:venueadmin_id/venues/:venue_id/categorys/:category_id/photos
  def create
    @category.photos.create!(photo_params)
    json_response(@category, :created)
  end

  # PUT /venueadmins/:venueadmin_id/venues/:venue_id/categorys/:category_id/photos/:id
  def update
    @photo.update(photo_params)
    head :no_content
  end

  # DELETE /venueadmins/:venueadmin_id/venues/:venue_id/categorys/:category_id/photos/:id
  def destroy
    @photo.destroy
    head :no_content
  end

  private

  def photo_params
    params.permit(:filename, :caption, :rank)
  end

  def set_category
    @category = Category.find(params[:category_id])
  end

  def set_category_photo
    @photo = @category.photos.find_by!(id: params[:id]) if @category
  end

end
