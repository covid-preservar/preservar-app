# frozen_string_literal: true
class SellerSignupForm
  include ActiveModel::Model
  include ActiveModel::AttributeMethods

  attr_accessor :name,
                :district,
                :area,
                :address,
                :category_id,
                :main_photo,
                :cached_main_photo_data,
                :email,
                :is_company,
                :vat_id,
                :iban,
                :company_registration_code,
                :contact_name,
                :company_name,
                :password,
                :password_confirmation,
                :accept_tos

  attr_writer :seller, :seller_user, :place

  validates :name,
            :address,
            :district,
            :area,
            :contact_name,
            :password,
            :password_confirmation,
            :category_id,
            :main_photo,
            :iban,
            :vat_id,
            :company_name, presence: true

  validates :email, format: { with: Devise.email_regexp }

  validates :password, presence: true,
                       confirmation: true,
                       length: { within: Devise.password_length }

  validates :company_registration_code,
            format: { with: /\d{4}-\d{4}-\d{4}/, allow_nil: true }

  validates :accept_tos, acceptance: true
  validate :validate_vat_id
  validate :validate_iban

  def initialize(attributes = {})
    super(attributes.reject { |_, v| v.blank? })
    @iban = @iban.squish.tr('.', ' ') if @iban.present?

    @cached_main_photo_data = place.cached_main_photo_data
  end

  def category
    @category ||= Category.find_by(id: category_id)
  end

  def seller_user
    @seller_user ||= SellerUser.new(email: email,
                                    password: password,
                                    password_confirmation: password_confirmation)
  end

  def seller
    @seller ||= Seller.new(vat_id: vat_id,
                           contact_name: contact_name,
                           company_name: company_name,
                           iban: iban,
                           company_registration_code: company_registration_code,
                           seller_user: seller_user)
  end

  def place
    @place ||= seller.places.build(name: name,
                                   area: area,
                                   address: address,
                                   category_id: category_id,
                                   main_photo: main_photo)
  end

  def save
    return false unless valid?

    ActiveRecord::Base.transaction do
      seller_user.save!
      seller.save!
      place.save!
      yield if block_given?
    end

    true
  rescue StandardError
    copy_errors
    false
  end

  private

  def copy_errors
    [seller_user, seller, place].each do |model|
      model.errors.each do |attribute, error|
        errors.add(attribute, error)
      end
    end
  end

  def validate_iban
    errors.add(:iban, 'é inválido') unless Ibandit::IBAN.new(iban).valid?
  end

  def validate_vat_id
    to_validate = 'PT' + vat_id.tr('PT', '')
    errors.add(:vat_id, :invalid_vat) unless Valvat.new(to_validate).valid_checksum?
  end

end
