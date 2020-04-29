# frozen_string_literal: true
class SellerUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :seller, dependent: :restrict_with_exception
  has_many :places, through: :seller


  def accept_tos!
    update!(
      privacy_policy_version_consented_to: ENV.fetch('PRIVACY_POLICY_VERSION'),
      terms_of_service_version_consented_to: ENV.fetch('TERMS_OF_SERVICE_VERSION'),
      tos_accepted_at: Time.now
    )
  end

  def needs_new_tos_acceptance?
    (ENV.fetch('PRIVACY_POLICY_VERSION') != privacy_policy_version_consented_to) ||
    (ENV.fetch('TERMS_OF_SERVICE_VERSION') != terms_of_service_version_consented_to)
  end

  def to_s
    "SellerUser ##{id}:<#{email}>"
  end
end
