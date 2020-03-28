# frozen_string_literal: true
class SellerUsers::RegistrationsController < Devise::RegistrationsController

  def new
    super do
      @form = SellerSignupForm.new(seller_user: resource)

      gon.locations = Location.grouped_areas
    end
  end

  def create
    @form = SellerSignupForm.new(signup_params)
    if @form.save
      ApplicationMailer.seller_signup(@form.seller.id).deliver_later
      ApplicationMailer.seller_signup_notify_internal(@form.seller.id).deliver_later
      expire_data_after_sign_in!
      redirect_to register_success_path
    else
      # clean_up_passwords resource
      set_minimum_password_length
      gon.locations = Location.grouped_areas
      render :new
    end
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
