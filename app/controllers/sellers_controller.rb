class SellersController < Admin::ApplicationController
  
  def index
    @spinner_categories = Category.order("RANDOM()").limit(5)

    # @sellers = Seller.where(city: params[:city], category: params[:category])
    @sellers = Seller.all
    render :index, layout:'homepage'
  end
end