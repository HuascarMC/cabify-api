class CabsController < ApplicationController
 # before_action :set_cab, only: [:show, :update, :destroy]

 # GET /cabs
 def index
   @cabs = current_user.cab
   json_response(@cabs)
 end

 # POST /cabs
 def create
   @cab = current_user.cabs.create!(cab_params)
   json_response(@cab, :created)
 end

 # GET /cabs/:id
 def show
   json_response(@cab)
 end

 # PUT /cabs/:id
 def update
   @cab.update(cab_params)
   head :no_content
 end

 # DELETE /cabs/:id
 def destroy
   @cab.destroy
   head :no_content
 end

 private

 def cab_params
   # whitelist params
   params.permit(:state, :name, :city)
 end

 def set_cab
   @cab = Cab.find(params[:id])
 end
end
