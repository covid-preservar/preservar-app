# frozen_string_literal: true
module Admin
  class PlacesController < Admin::ResourcefulController
    before_action :find_place, only: %i[publish unpublish]
    before_action :load_locations, only: %i[new edit create update]

    def index_columns
      [
        { attr: :id, label: 'ID', sort: :id },
        { attr: :name, label: 'Name', sort: :name },
        { attr: :category, label: 'Category', sort: nil, formatter: ->(view, place) { view.link_to place.category.name, [:admin, place.category] }  },
        { attr: :area, label: 'Area', sort: :area },
        { attr: :published, label: 'Published', sort: :published },
        { attr: :created_at, label: 'Created At', sort: :created_at },
        { attr: :updated_at, label: 'Updated At', sort: :updated_at }
      ]
    end

    def publish
      authorize! :publish, @resource

      if @resource.can_publish?

        if @resource.published_at.nil?
          ApplicationMailer.seller_place_published_notification(@resource.id).deliver_later
        end
        @resource.update(published: true, published_at: Time.now)

      else
        flash[:alert] = "Can't publish. Place needs photo and payment API key"
      end
      redirect_to [:admin, @resource], notice: 'Place was published'
    end

    def unpublish
      authorize! :unpublish, @resource
      @resource.update(published: false)
      redirect_to [:admin, @resource], notice: 'Place was unpublished'
    end

    def find_resource(slug)
      @resource = Place.friendly.find(slug)
    end

    def find_place
      @resource = Place.friendly.find(params[:id])
    end

    protected

    def permitted_params
      super.permit!
    end

    private

    def load_locations
      gon.locations = Location.grouped_areas
    end
  end
end
