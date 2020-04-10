require "administrate/base_dashboard"

class CharityPartnerDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    partnerships: Field::HasMany,
    places: Field::HasMany,
    id: Field::Number,
    type: Field::String,
    name: Field::String,
    slug: Field::String,
    large_logo: ShrineField,
    small_logo: ShrineField,
    place_page_copy: Field::String,
    voucher_copy: Field::String,
    partner_properties: Field::String.with_options(searchable: false),
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    min_value: Field::Number.with_options(prefix: "€ "),
    charity_value: Field::Number.with_options(prefix: "€ "),
    target_value: Field::Number.with_options(prefix: "€ ")
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = %i[
    id
    name
    slug
    partnerships
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = %i[
    id
    name
    slug
    place_page_copy
    voucher_copy
    min_value
    charity_value
    target_value
    created_at
    updated_at
    partner_properties
    partnerships
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = %i[
    name
    slug
    large_logo
    small_logo
    place_page_copy
    voucher_copy
    min_value
    charity_value
    target_value
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

  # Overwrite this method to customize how charity partners are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(charity_partner)
  #   "CharityPartner ##{charity_partner.id}"
  # end
end
