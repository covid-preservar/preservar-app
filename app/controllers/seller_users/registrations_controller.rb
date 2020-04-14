# frozen_string_literal: true
class SellerUsers::RegistrationsController < Lib::RegistrationsController

  def new
    super do
      @form = SellerSignupForm.new(seller_user: resource)
    end
  end

  def create
    @form = SellerSignupForm.new(signup_params)
    super
  end

  private

  def signup_params
    params.require(:seller_user).permit(:name,
                                        :district,
                                        :area,
                                        :address,
                                        :main_photo,
                                        :category_id,
                                        :email,
                                        :password,
                                        :vat_id,
                                        :iban,
                                        :company_registration_code,
                                        :password,
                                        :password_confirmation,
                                        :contact_name,
                                        :company_name)
  end
end
