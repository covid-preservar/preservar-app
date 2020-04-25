module Admin
  class CSVImportsController < Admin::ResourcefulController

    def index_columns
      [
        {attr: :id, label: 'ID', sort: :id},
        {attr: :admin_user, label: 'AdminUser', sort: :admin_user_id, formatter: -> (view, record) { record.admin_user }},
        {attr: :state, label: 'State', sort: :state}
      ]
    end

    def new
      super do
        @resource.admin_user = current_admin_user
      end
    end

    def create
      super do
        @resource.admin_user = current_admin_user
      end
    end

    def show_attributes
      [
        {attr: :id, label: 'ID' },
        {attr: :admin_user, label: 'Admin User' },
        {attr: :file_data, label: 'File Data' },
        {attr: :bad_vat_lines_count, label: 'Bad Vat Lines Count' },
        {attr: :not_found_lines_count, label: 'Not Found Lines Count' },
        {attr: :no_key_lines_count, label: 'No Key Lines Count' },
        {attr: :dup_key_lines_count, label: 'Dup Key Lines Count' },
        {attr: :publish_failed_ids, label: 'Publish Failed Ids' },
        {attr: :published_ids, label: 'Published Ids' },
        {attr: :state, label: 'State' }
      ]

    end

    protected

    def search_disabled
      true
    end

    def after_upsert(type)
      if type == :create && @resource.persisted?
        SellerCSVImport.perform_later @resource.id
      end
    end

    def permitted_params
      super.permit!
    end
  end
end
