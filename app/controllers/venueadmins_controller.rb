class VenueadminsController < ApplicationController
  before_action :set_venueadmin, only: [:show, :update, :destroy]

  # GET /venueadmins
  def index
    # Get all the venueadmins and order them via their email
    venueadmins = Venueadmin.order(email: :asc)    
    render json: venueadmins.as_json(include: { venues: { include: {categorys: { include: :photos }}}})
  end

  # POST /venueadmins
  def create
    @venueadmin = Venueadmin.create!(venueadmin_params)
    json_response(@venueadmin, :created)
  end

  # GET /venueadmins/:id
  def show
    render json: @venueadmin.as_json(include: { venues: { include: {categorys: { include: :photos }}}})
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
