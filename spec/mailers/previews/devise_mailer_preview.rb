class DeviseMailerPreview < ActionMailer::Preview
  # def confirmation_instructions
  #   Devise::Mailer.confirmation_instructions(User.first, {})
  # end

  def unlock_instructions
    Devise::Mailer.unlock_instructions(SellerUser.first, "faketoken")
  end

  def reset_password_instructions
    Devise::Mailer.reset_password_instructions(SellerUser.first, "faketoken")
  end

  def password_change
    Devise::Mailer.password_change(SellerUser.first)

  end

  def email_changed
    Devise::Mailer.email_changed(SellerUser.first)
  end
end
