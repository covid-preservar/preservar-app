class AddTrackingCodesToVouchers < ActiveRecord::Migration[6.0]
  def change
    enable_extension 'hstore' unless extension_enabled?('hstore')
    add_column :vouchers, :tracking_codes, :hstore, default: {}
  end
end
