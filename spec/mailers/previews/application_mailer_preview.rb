class ApplicationMailerPreview < ActionMailer::Preview

  def seller_signup
    ApplicationMailer.seller_signup(Seller.first)
  end
end