# frozen_string_literal: true
class Seller::PlacesController < Seller::BaseController
  before_action :load_place, except: %i[new create]

  def show
  end

  def new
    @place = current_seller_user.seller.places.build
    gon.locations = Location.grouped_areas
  end

  def create
    @place = current_seller_user.seller.places.build(place_params)

    if @place.save
      redirect_to seller_place_path(@place), notice: 'Local criado com sucesso, aguarda validação.'
    else
      gon.locations = Location.grouped_areas
      render :new
    end
  end

  def enable_discount
  end

  def confirm_discount
    @place.update has_discount: true
    redirect_to seller_place_path(@place)
  end

  def disable_discount
  end

  def confirm_disable_discount
    @place.update has_discount: false
    redirect_to seller_place_path(@place)
  end

  private

  def load_place
    @place = current_seller_user.places.friendly.find(params[:id])
  end

  def place_params
    params.require(:place).permit(:name, :category_id, :district, :area, :address, :main_photo)
  end
end
