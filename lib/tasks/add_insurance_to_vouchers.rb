task :add_insurance_to_vouchers => :environment do
  Voucher.paid
         .where('created_at >= ?', Date.today.beginning_of_day)
         .where(insurance_policy_number: nil)
         .each do |voucher|

    if voucher.can_insure?
      InsurancePolicyService.new(@voucher).create_policy

      if voucher.reload.insurance_temp_password.present?
        ApplicationMailer.followup_insurance_email(voucher.id)
      end
    end
  end
end
