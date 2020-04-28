# frozen_string_literal: true
class Seller::PlacesController < Seller::BaseController
  before_action :load_place, except: %i[new create]
  before_action :load_locations, only: %i[new edit create update]

  def show
    redirect_to(seller_place_url(@place)) and return if seller_place_url(@place) != request.url
  end

  def new
    @place = current_seller_user.seller.places.build
  end

  def create
    @place = current_seller_user.seller.places.build(place_params)

    if @place.save
      redirect_to seller_place_path(@place), notice: 'Local criado com sucesso, aguarda validação.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @place.update(place_params)
      redirect_to seller_place_path(@place), notice: 'Alterações guardadas com sucesso.'
    else
      render :edit
    end
  end

  private

  def load_place
    @place = current_seller_user.places.friendly.find(params[:id])
  end

  def place_params
    params.require(:place).permit(:name, :category_id, :district, :area, :address, :main_photo)
  end
end
