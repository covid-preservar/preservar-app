# frozen_string_literal: true
class Lib::RegistrationsController < Devise::RegistrationsController

  def new
    if current_seller_user.blank?
      super do
        gon.locations = Location.grouped_areas

        yield if block_given?
      end
    else
      redirect_to after_sign_in_path_for(current_seller_user)
    end
  end

  def create
    if @form.save
      SellerPostSignupJob.perform_later(@form.seller.id)
      expire_data_after_sign_in!

      redirect_to register_success_path
    else
      clean_up_passwords resource
      set_minimum_password_length
      gon.locations = Location.grouped_areas
      render :new
    end
  end

end