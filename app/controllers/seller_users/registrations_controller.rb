class SellerUsers::RegistrationsController < Devise::RegistrationsController

  def new
    super do
      @form = SellerSignupForm.new(seller_user: resource)
    end
  end

  def create
    @form = SellerSignupForm.new(signup_params)
    if @form.save
      user = @form.seller_user
      if user.active_for_authentication?
        set_flash_message! :notice, :signed_up
        sign_up(resource_name, user)
        redirect_to after_sign_up_path_for(user)
      else
        set_flash_message! :notice, :"signed_up_but_#{user.inactive_message}"
        expire_data_after_sign_in!
        redirect_to after_inactive_sign_up_path_for(user)
      end
    else
      flash.now[:alert] = 'Please review the problems below.'
      clean_up_passwords resource
      set_minimum_password_length
      render :new
    end
  end

  private

  def signup_params
    params.require(:seller_user).permit(:name,
                                        :category_id,
                                        :average_value_per_person,
                                        :email,
                                        :password,
                                        :vat_id,
                                        :iban,
                                        :eni_name,
                                        :company_registration_code,
                                        :password,
                                        :password_confirmation)
  end
end
