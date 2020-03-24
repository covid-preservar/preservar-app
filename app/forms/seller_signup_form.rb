class SellerSignupForm
  include ActiveModel::Model
  include ActiveModel::AttributeMethods

  attr_accessor :name,
                :category_id,
                :average_value_per_person,
                :email,
                :password,
                :is_company,
                :vat_id,
                :iban,
                :contact_name,
                :company_name,
                :company_registration_code,
                :password,
                :password_confirmation,
                :seller_user,
                :seller

  validates :name, :contact_name, presence: true

  validates :email, format: {with: Devise.email_regexp}

  validates :category_id,
            :password,
            :password_confirmation, presence: true


  validates :vat_id, valvat: true
  validates :company_registration_code,
            format: { with: /\d{4}-\d{4}-\d{4}/ },
            if: :is_company
  validates :company_name, presence: true, if: :is_company

  validate :validate_iban
  validate :validate_vat_id

  def initialize(attributes = {})
    super
    @name ||= seller_user&.seller&.name
    @email ||= seller_user.email
    @category_id ||= seller_user&.seller&.category_id
    @average_value_per_person ||= seller_user&.seller&.average_value_per_person
    @password ||= seller_user.password
    @password_confirmation ||= seller_user.password_confirmation
    @vat_id ||= seller_user&.seller&.vat_id
    @iban ||= seller_user&.seller&.iban
    @contact_name ||= seller_user&.seller&.contact_name
    @company_registration_code ||= seller_user&.seller&.company_registration_code
    @is_company = @is_company == 'false' ? false : true
  end

  def category
    @category ||= Category.find_by(id: category_id)
  end

  def seller_user
    @seller_user ||= SellerUser.new(email: email,
                                    password: password,
                                    password_confirmation: password_confirmation,
                                    seller: seller)

  end

  def seller
    @seller ||= Seller.new(name: name,
                           category_id: category_id,
                           average_value_per_person: average_value_per_person,
                           vat_id: vat_id,
                           iban: iban,
                           contact_name: contact_name,
                           company_name: company_name,
                           company_registration_code: company_registration_code)
  end

  def save
    return true
    return false unless valid?
    seller.save!
    seller_user.save!
  rescue StandardError
    copy_errors
    false
  end

  private

  def copy_errors
    seller_user.errors.each do |attribute, error|
      errors.add(attribute, error)
    end
    seller.errors.each do |attribute, error|
      errors.add(attribute, error)
    end
  end

  def validate_iban
    errors.add(:iban, 'é inválido') unless Ibandit::IBAN.new(iban).valid?
  end

end