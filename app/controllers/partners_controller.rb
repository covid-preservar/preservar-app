# frozen_string_literal: true
class PartnersController < ApplicationController

  def index
    @partner = Partner.find_by(slug: request.subdomain)
    @places = @partner.places.published

    @accumulated = @partner.vouchers.paid.sum(:value)
    render @partner.slug
  end

  protected

  def body_class
    "#{super} loreal"
  end
end
