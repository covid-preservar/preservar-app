# frozen_string_literal: true
module Admin
  class SellerUsersController < Admin::ResourcefulController

    def index_columns
      [
        {attr: :id, label: 'ID', sort: :id},
        {attr: :email, label: 'Email', sort: :email},
        {attr: :seller, label: 'Seler', sort: nil, formatter: -> (view, seller_user) { view.link_to "Seller: #{seller_user.seller}", [:admin, seller_user.seller] }},
        {attr: :created_at, label: 'Created At', sort: :created_at},
        {attr: :updated_at, label: 'Updated At', sort: :updated_at}
      ]
    end

    def show_attributes
      super.insert(1, {attr: :seller, label: 'Seller', formatter: -> (view, seller_user) { view.link_to "Seller: #{seller_user.seller}", [:admin, seller_user.seller] }})
    end

    protected

    def permitted_params
      super.permit!
    end
  end
end
