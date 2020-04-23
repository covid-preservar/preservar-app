
# frozen_string_literal: true
module Admin
  class PartnersController < Admin::ResourcefulController
    def index_columns
      [
        {attr: :id, label: 'ID', sort: :id},
        {attr: :name, label: 'Name', sort: :name},
        {attr: :slug, label: 'Slug', sort: :slug},
        {attr: :created_at, label: 'Created At', sort: :created_at},
        {attr: :updated_at, label: 'Updated At', sort: :updated_at}
      ]
    end

    def new
      super do
        @resource = (params[:type].classify + 'Partner').constantize.new
      end
    end

    protected

    def resource_link(resource)
      admin_partner_path resource
    end

    def after_upsert_path
      polymorphic_path([:admin, @resource])
    end

    def upsert_action_link
      @resource.persisted? ? admin_partner_path(@resource.id) : admin_partners_path
    end

    def edit_resource_link(resource)
      edit_admin_partner_path resource
    end

    def search_disabled
      true
    end

    def permitted_params
      super.permit!
    end
  end
end
