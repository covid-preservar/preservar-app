# frozen_string_literal: true
class SellerUsers::PartnerRegistrationsController < Lib::RegistrationsController

  def new
    @partner = Partner.find_by(slug: request.subdomain)

    super do
      @form = PartnerSellerSignupForm.new(seller_user: resource, partner: @partner)
    end
  end

  def create
    @partner = Partner.find_by(slug: request.subdomain)
    @form = PartnerSellerSignupForm.new(signup_params.merge(partner: @partner))
    super
  end

  protected

  def body_class
    "#{super} loreal partners"
  end

  private

  def signup_params
    params.require(:seller_user).permit(:name,
                                        :district,
                                        :area,
                                        :address,
                                        :main_photo,
                                        :email,
                                        :password,
                                        :vat_id,
                                        :iban,
                                        :company_registration_code,
                                        :password,
                                        :password_confirmation,
                                        :contact_name,
                                        :company_name,
                                        :partner_id_code)
  end

end