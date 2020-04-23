# frozen_string_literal: true
class AdminUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :registerable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable, :trackable

  enum role: { disabled: 0,
               basic_user: 1,
               super_user: 99 }

  def to_s
    "Admin: <#{email}>"
  end
end
