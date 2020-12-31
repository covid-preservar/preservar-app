# frozen_string_literal: true
class Admin::Ability
  include CanCan::Ability

  def initialize(user)
    @user = user
    alias_action :create, :update, :destroy, :to => :write

    if @user.disabled?
      disabled_admin_user_permissions
      return
    end

    apply_default_permissions

    case @user.role
    when 'basic_user'
      apply_basic_user_permissions
    when 'super_user'
      apply_super_user_permissions
    end

    apply_base_admin_permissions
  end

  def disabled_admin_user_permissions
    cannot :manage, :all
  end

  def apply_default_permissions
    cannot :write, :all
    can :show, AdminUser, id: @user.id
    can :update, AdminUser, id: @user.id
    can :resend, Voucher
    can :create, Partnership
  end

  def apply_basic_user_permissions
    can :read, :all
  end

  def apply_super_user_permissions
    can :manage, :all
  end

  def apply_base_admin_permissions
    can :read, AdminUser
    cannot :destroy, PaymentNotification
    cannot :destroy, PartnerIdentifier

    cannot :destroy, Place do |place|
      place.vouchers.any?
    end

    cannot :destroy, Seller do |seller|
      seller.places.any?
    end

    cannot :destroy, SellerUser do |seller_user|
      seller_user.seller.present?
    end

    cannot :publish, Place do |place|
      !place.can_publish?
    end

    cannot :unpublish, Place do |place|
      !place.published?
    end

    cannot :resend, Voucher do |voucher|
      !voucher.paid?
    end

    cannot :mark_refunded, Voucher do |voucher|
      !voucher.paid?
    end
  end
end
