# frozen_string_literal: true
module Admin
  class PartnershipsController < Admin::ResourcefulController

    def index_columns
      [
        {attr: :id, label: 'ID', sort: :id},
        {attr: :partner, label: 'Partner', sort: nil, formatter: -> (view, ps) { view.link_to ps.partner, view.admin_partner_path(ps.partner) } },
        {attr: :place, label: 'Place', sort: nil, formatter: -> (view, ps) { view.link_to "Place: #{ps.place.name}", [:admin, ps.place] } },
        {attr: :approved, label: 'Approved', sort: :approved},
        {attr: :limit_reached, label: 'Limit Reached', sort: :limit_reached},
        {attr: :created_at, label: 'Created At', sort: :created_at},
        {attr: :updated_at, label: 'Updated At', sort: :updated_at}
      ]
    end

    def show_attributes
      [
        {attr: :id, label: 'ID'},
        {attr: :partner, label: 'Partner', formatter: -> (view, ps) { view.link_to ps.partner, [:admin, ps.partner] } },
        {attr: :place, label: 'Place', formatter: -> (view, ps) { view.link_to "Place: #{ps.place.name}", [:admin, ps.place] } },
        {attr: :approved, label: 'Approved'},
        {attr: :limit_reached, label: 'Limit Reached'},
        {attr: :partner_identifier, label: 'Partner Identifier', formatter: -> (view, ps) { view.link_to "PartnerIdentifier: #{ps.partner_identifier.identifier}", [:admin, ps.partner_identifier] }},
        {attr: :created_at, label: 'Created At'},
        {attr: :updated_at, label: 'Updated At'}
      ]
    end

    def new
      super do
        @resource.place = Place.find(params[:place_id]) if params[:place_id].present?
      end
    end

    protected

    def permitted_params
      super.permit!
    end

  end
end
