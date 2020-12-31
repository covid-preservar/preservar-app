# frozen_string_literal: true
module Admin
  class PaymentNotificationsController < Admin::ResourcefulController

    def index_columns
      [
        { attr: :id, label: 'ID', sort: :id },
        { attr: :data, label: 'Data', sort: nil, formatter: -> (view, pn) { view.truncate(pn.data.to_s) } },
        { attr: :status, label: 'Status', sort: :status },
        { attr: :created_at, label: 'Created At', sort: :created_at },
        { attr: :updated_at, label: 'Updated At', sort: :updated_at }
      ]
    end
  end
end
