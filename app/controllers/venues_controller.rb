class VenuesController < ApplicationController

  before_action :set_venueadmin
  before_action :set_venueadmin_venue, only: [:show, :update, :destroy]

  # GET /venueadmins/:venueadmin_id/venues
  def index
    render json: @venueadmin.venues.as_json(include: { categorys: { include: :photos }})
  end

  # GET /venueadmins/:venueadmin_id/venues/:id
  def show
    render json: @venue.as_json(include: { categorys: { include: :photos }})
  end

  # POST /venueadmins/:venueadmin_id/venues
  def create
    @venueadmin.venues.create!(venue_params)
    json_response(@venueadmin, :created)
  end

  # PUT /venueadmins/:venueadmin_id/venues/:id
  def update
    @venue.update(venue_params)
    head :no_content
  end

  # DELETE /venueadmins/:venueadmin_id/venues/:id
  def destroy
    @venue.destroy
    head :no_content
  end

  private

  def venue_params
    params.permit(:name)
  end

  def set_venueadmin
    @venueadmin = Venueadmin.find(params[:venueadmin_id])
  end

  def set_venueadmin_venue
    @venue = @venueadmin.venues.find_by!(id: params[:id]) if @venueadmin
  end

end
