class CategorysController < ApplicationController

  before_action :set_venue
  before_action :set_venue_category, only: [:show, :update, :destroy]

  # GET /venueadmins/:venueadmin_id/venues/:venue_id/categorys
  def index
    render json: @venue.categorys.as_json(include: :photos)
  end

  # GET /venueadmins/:venueadmin_id/venues/:venue_id/categorys/:id
  def show
    render json: @category.as_json(include: :photos)
  end

  # POST /venueadmins/:venueadmin_id/venues/:venue_id/categorys
  def create
    @venue.categorys.create!(category_params)
    json_response(@venue, :created)
  end

  # PUT /venueadmins/:venueadmin_id/venues/:venue_id/categorys/:id
  def update
    @category.update(category_params)
    head :no_content
  end

  # DELETE /venueadmins/:venueadmin_id/venues/:venue_id/categorys/:id
  def destroy
    @category.destroy
    head :no_content
  end

  private

  def category_params
    params.permit(:name)
  end

  def set_venue
    @venue = Venue.find(params[:venue_id])
  end

  def set_venue_category
    @category = @venue.categorys.find_by!(id: params[:id]) if @venue
  end

end
