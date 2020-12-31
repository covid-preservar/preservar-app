# frozen_string_literal: true
class Lib::RegistrationsController < Devise::RegistrationsController
  before_action :load_locations, only: %i[new create]

  def new
    if current_seller_user.blank?
      super do
        yield if block_given?
      end
    else
      redirect_to after_sign_in_path_for(current_seller_user)
    end
  end

  def create
    if @form.save
      SellerPostSignupJob.perform_later(@form.seller.id)
      sign_up(:seller_user, @form.seller_user)
      redirect_to register_success_path
    else
      clean_up_passwords resource
      set_minimum_password_length
      render :new
    end
  end
end
