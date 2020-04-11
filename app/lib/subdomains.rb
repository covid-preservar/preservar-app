module Subdomains
  class Partner
    class << self
      attr_accessor :subdomains
    end

    def self.subdomains
      return unless load_subdomains?

      ::Partner.pluck(:slug)
    end

    def self.load_subdomains?
      ::ActiveRecord::Base.connection.table_exists?("partners")
    end

    def self.matches?(request)
      subdomains.include?(request.subdomain)
    end
  end
end