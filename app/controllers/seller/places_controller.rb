# frozen_string_literal: true
class Seller::PlacesController < Seller::BaseController
  before_action :load_place, except: %i[new create]
  before_action :load_locations, only: %i[new edit create update]

  def show
    redirect_to(seller_place_url(@place)) and return if seller_place_url(@place) != request.url
  end

  def new
    redirect_to(seller_account_url) and return unless Flipper.enabled?(:registration)

    @place = current_seller_user.seller.places.build
  end

  def create
    redirect_to(seller_account_url) and return unless Flipper.enabled?(:registration)

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

  def publish
    if @place.can_publish?
      @place.update(published: true, published_at: Time.now)
      redirect_to seller_place_path(@place), notice: 'Este local foi publicado'
    else
      redirect_to seller_place_path(@place), alert: 'Não é possivel publicar este local. Por favor contacte-nos'
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
