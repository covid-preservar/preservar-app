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

      set_flash_message! :notice, :"signed_up_but_#{user.inactive_message}"
      expire_data_after_sign_in!

    else
      # clean_up_passwords resource
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
                                        :password_confirmation,
                                        :is_company,
                                        :contact_name,
                                        :company_name)
  end
end
