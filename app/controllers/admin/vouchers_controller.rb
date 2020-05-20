# frozen_string_literal: true
module Admin
  class VouchersController < Admin::ResourcefulController

    def index_columns
      [
        {attr: :id, label: 'ID', sort: :id},
        {attr: :place, label: 'Place', sort: nil, formatter: -> (view, voucher) { view.link_to "Place: #{voucher.place.name}", [:admin, voucher.place] } },
        {attr: :email, label: 'Email', sort: :email },
        {attr: :value, label: 'Face Value', sort: nil, formatter: -> (view, voucher) { view.number_to_currency voucher.face_value, locale: :pt }},
        {attr: :value, label: 'Paid Value', sort: :value, formatter: -> (view, voucher) { view.number_to_currency voucher.value, locale: :pt }},
        {attr: :value, label: 'Used Value', sort: :used_value, formatter: -> (view, voucher) { view.number_to_currency voucher.used_value, locale: :pt }},
        {attr: :state, label: 'State', sort: :state},
        {attr: :created_at, label: 'Created At', sort: :created_at}
      ]
    end

    def resend
      find_resource(params[:id])
      authorize! :resend, @resource

      ApplicationMailer.voucher_email(@resource.id).deliver_later
      redirect_to [:admin, @resource], notice: 'Resending voucher email.'
    end

    def mark_refunded
      find_resource(params[:id])
      authorize! :mark_refunded, @resource

      @resource.mark_refunded!
      redirect_to [:admin, @resource], notice: 'Voucher was marked as refunded'
    end

    protected

    def permitted_params
      super.permit!
    end
  end
end
