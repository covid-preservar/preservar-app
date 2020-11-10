# frozen_string_literal: true
class Seller::AccountsController < Seller::BaseController
  skip_before_action :authenticate_seller_user!, only: [:republish]
  before_action :load_signin_token, only: [:republish]

  def show
    @seller = current_seller_user.seller
  end

  def accept_new_terms
    current_seller_user.accept_tos!
    redirect_to request.referrer
  end

  def republish
    @seller = current_seller_user.seller
    errors = []
    # Only republish places that were previously published
    to_republish = @seller.places.where(published: false).where.not(published_at:nil)

    redirect_to(seller_account_path) and return if to_republish.empty?

    to_republish.each do |place|

      if place.can_publish?
        place.update(published: true, published_at: Time.now)
      else
        errors << place
      end
    end

    if errors.any?
      flash[:alert] = "Não foi possivel publicar: #{errors.map(&:name).join(', ')}.\nPor favor contacte-nos.".html_safe
    else
      flash[:notice] = 'Os seus locais foram publicados'
    end

    redirect_to seller_account_path
  end

  private

  def load_signin_token
    uuid = params[:signin_token]
    token = SigninToken.get_from_uuid(uuid) if uuid.present?
    @current_signin_token = token

    token.destroy! if token&.expired?

    redirect_to(root_path, alert: 'Link inválido') and return unless token.present?

    if current_seller_user.present? && token.seller_user != current_seller_user
      redirect_to(seller_account_path,
                  alert: "Erro: Já se encontra autenticado como #{current_seller_user.email}")
    else
      seller_user = token.seller_user
      sign_in(:seller_user, seller_user)
    end
  end
end
