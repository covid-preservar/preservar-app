# frozen_string_literal: true
class VoucherRedeemForm
  include ActiveModel::Model
  include ActiveModel::AttributeMethods

  attr_accessor :used_value, :voucher, :new_voucher

  validates :used_value, numericality: { greater_than: 0,
                                         less_than_or_equal_to: ->(form) { form.voucher.face_value }}

  def initialize(attributes = {})
    super(attributes.reject { |_, v| v.blank? })
    @used_value = attributes[:used_value].nil? ? voucher.face_value : @used_value.to_f
  end

  def save
    return false unless valid?

    @new_voucher = voucher.redeem_with_value!(used_value)

    if @new_voucher.present?
      ApplicationMailer.remainder_voucher_email(new_voucher_id: @new_voucher.id, original_voucher_id: voucher.id).deliver_later
    end

    true
  end

end