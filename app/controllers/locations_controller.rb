class LocationsController < ApplicationController
  before_action :set_cab
  before_action :set_cab_location, only: [:show, :update, :destroy]

  # GET /cabs/:cab_id/locations
  def index
    json_response(@cab.location)
  end

  # GET /cabs/:cab_id/locations/:id
  def show
    json_response(@location)
  end

  # POST /cabs/:cab_id/locations
  def create
    @cab.location.create!(location_params)
    json_response(@cab, :created)
  end

  # PUT /cabs/:cab_id/locations/:id
  def update
    @location.update(location_params)
    head :no_content
  end

  # DELETE /cabs/:cab_id/locations/:id
  def destroy
    @location.destroy
    head :no_content
  end

  private

  def location_params
    params.permit(:lon, :lat)
  end

  def set_cab
    @cab = Cab.find(params[:cab_id])
  end

  def set_cab_location
    @location = @cab.location.find_by!(id: params[:id]) if @cab
  end
end
