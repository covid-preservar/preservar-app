# frozen_string_literal: true
require 'administrate/base_dashboard'

class VoucherDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    place: Field::BelongsTo,
    id: Field::Number,
    code: Field::String,
    value: Field::Number,
    state: Field::String,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    payment_completed_at: Field::DateTime,
    email: Field::String,
    payment_identifier: Field::String,
    payment_method: Field::String,
    payment_phone: Field::String,
    cookie_uuid: Field::String,
    vat_id: Field::String,
    valid_until: Field::Date,
    tracking_codes: Field::Text,
    partner: Field::Polymorphic
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = %i[
    id
    place
    email
    code
    value
    valid_until
    state
    partner
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = %i[
    id
    place
    email
    vat_id
    value
    code
    valid_until
    state
    payment_completed_at
    created_at
    updated_at
    tracking_codes
    payment_identifier
    payment_method
    payment_phone
    cookie_uuid
    partner
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = %i[
    place
    code
    value
    state
    email
    valid_until
    payment_identifier
    payment_method
    payment_phone
    cookie_uuid
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

  # Overwrite this method to customize how vouchers are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(voucher)
  #   "Voucher ##{voucher.id}"
  # end
end
