class PartnersController < ApplicationController

  def index
    @partner = Partner.find_by(slug: request.subdomain)
    @places = @partner.places.published
    render @partner.slug
  end

  protected

  def body_class
    "#{super} loreal"
  end
end
