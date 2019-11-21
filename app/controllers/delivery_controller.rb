class DeliveryController < ApplicationController
  before_action :delivery_params, only: [:update]
  
  def update
    @delivery = Delivery.find(params[:id])
    @delivery.update(delivery_params)
    render :identification
  end

  private
    def delivery_params
      params.require(:delivery).permit(:postal_code, :ken, :map, :banchi, :building)
    end
end