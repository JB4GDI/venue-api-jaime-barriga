class VenueadminsController < ApplicationController
  before_action :set_venueadmin, only: [:show, :update, :destroy]

  # GET /venueadmins
  def index
    # Get all the venueadmins and order them via their email
    venueadmins = Venueadmin.order(email: :asc)
    json_response(venueadmins)
  end

  # POST /venueadmins
  def create
    @venueadmin = Venueadmin.create!(venueadmin_params)
    json_response(@venueadmin, :created)
  end

  # GET /venueadmins/:id
  def show
    json_response(@venueadmin)
  end

  # PUT /venueadmins/:id
  def update
    @venueadmin.update(venueadmin_params)
    head :no_content
  end

  # DELETE /venueadmins/:id
  def destroy
    @venueadmin.destroy
    head :no_content
  end


  private

  def venueadmin_params
    params.permit(:name,:email)
  end

  def set_venueadmin
    @venueadmin = Venueadmin.find(params[:id])
  end

  def render_errors(note)
    { errors: note.errors }
  end

end
