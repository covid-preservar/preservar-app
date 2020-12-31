# frozen_string_literal: true
require 'bcrypt'
class SigninToken < ApplicationRecord
  DEFAULT_DURATION = 5.days

  before_create :generate_and_encrypt_uuid
  before_save :set_expires_at

  belongs_to :seller_user

  scope :expired, -> { where('expires_at < ?', Date.today) }

  def self.get_from_uuid(dashless_uuid)
    encrypted_search = BCrypt::Engine.hash_secret(dashless_uuid, ENV['SIGNIN_TOKEN_SALT'])

    find_by_encrypted_uuid(encrypted_search)
  end

  def expired?
    DateTime.now > expires_at
  end

  def value
    uuid.delete('-')
  end

  def uuid
    @plaintext_uuid
  end

  private

  def generate_and_encrypt_uuid
    @plaintext_uuid = SecureRandom.uuid.delete('-')
    self.encrypted_uuid = BCrypt::Engine.hash_secret(@plaintext_uuid, ENV['SIGNIN_TOKEN_SALT'])
  end

  def set_expires_at
    self.expires_at ||= DateTime.now + DEFAULT_DURATION
  end
end
