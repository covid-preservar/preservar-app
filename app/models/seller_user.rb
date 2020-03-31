# frozen_string_literal: true
class SellerUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :seller, -> { unscoped }
  accepts_nested_attributes_for :seller
end
