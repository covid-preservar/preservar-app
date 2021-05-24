# frozen_string_literal: true
module Admin
  class SellersController < Admin::ResourcefulController

    def index_columns
      [
        { attr: :id, label: 'ID', sort: :id },
        { attr: :company_name, label: 'Company Name', sort: :company_name },
        { attr: :vat_id, label: 'VAT ID', sort: :vat_id },
        { attr: :payment_api_key, label: 'Payment API Key', sort: :payment_api_key },
        { attr: :created_at, label: 'Created At', sort: :created_at },
        { attr: :updated_at, label: 'Updated At', sort: :updated_at }
      ]
    end

    protected

    def permitted_params
      super.permit!
    end
  end
end
