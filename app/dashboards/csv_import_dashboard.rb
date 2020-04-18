require "administrate/base_dashboard"

class CSVImportDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    id: Field::Number,
    admin_user: Field::BelongsTo,
    file: ShrineField,
    file_data: Field::String.with_options(searchable: false),
    bad_vat_lines_count: Field::Number,
    not_found_lines_count: Field::Number,
    no_key_lines_count: Field::Number,
    dup_key_lines_count: Field::Number,
    publish_failed_ids: Field::String,
    published_ids: Field::String,
    state: Field::String.with_options(searchable: false),
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = %i[
    id
    state
    admin_user
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = %i[
    id
    admin_user
    file_data
    bad_vat_lines_count
    not_found_lines_count
    no_key_lines_count
    dup_key_lines_count
    publish_failed_ids
    published_ids
    state
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = %i[
    file
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

  # Overwrite this method to customize how csv imports are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(csv_import)
  #   "CSVImport ##{csv_import.id}"
  # end
end
