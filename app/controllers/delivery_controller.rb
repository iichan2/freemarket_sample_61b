class DeliveryController < ApplicationController
  def du_update
    @delivery = Delivery.find(params[:id])
    if @delivery.update(
      postal_code: params[:postal_code],
      ken: params[:ken],
      map: params[:map],
      banchi: params[:banchi],
      building: params[:building],
    )
      redirect_to user_path
    else
      render :identification
    end
  end
end