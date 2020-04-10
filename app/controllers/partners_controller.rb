class PartnersController < ApplicationController

  def index
    domain_length = ENV['HOSTNAME'].split('.').count - 1
    @partner = Partner.find_by(slug: request.subdomain(domain_length))
    @places = @partner.places.published
    render @partner.slug
  end

  protected

  def body_class
    "#{super} loreal"
  end
end
