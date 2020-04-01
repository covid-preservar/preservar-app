# frozen_string_literal: true
require 'administrate/base_dashboard'

class SellerDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    category: Field::BelongsTo,
    seller_user: Field::HasOne,
    vouchers: Field::HasMany,
    id: Field::Number,
    name: Field::String,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    area: Field::String,
    slug: Field::String,
    address: Field::String,
    published: Field::Boolean,
    main_photo_data: Field::String.with_options(searchable: false),
    payment_api_key: Field::String,
    vat_id: Field::String,
    contact_name: Field::String,
    company_name: Field::String,
    main_photo: ShrineField
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = %i[
    id
    name
    category
    area
    published
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = %i[
    id
    published
    category
    seller_user
    vouchers
    name
    created_at
    updated_at
    area
    slug
    address
    main_photo_data
    payment_api_key
    vat_id
    contact_name
    company_name
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = %i[
    category
    name
    area
    slug
    address
    published
    main_photo
    payment_api_key
    vat_id
    contact_name
    company_name
  ].freeze

  # COLLECTION_FILTERS
  # a hash that defines filters that can be used while searching via the search
  # field of the dashboard.
  #
  # For example to add an option to search for open resources by typing "open:"
  # in the search field:
  #
  #   COLLECTION_FILTERS = {
  #     open: ->(resources) { resources.where(open: true) }
  #   }.freeze
  COLLECTION_FILTERS = {}.freeze

  # Overwrite this method to customize how sellers are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(seller)
  #   "Seller ##{seller.id}"
  # end
end
