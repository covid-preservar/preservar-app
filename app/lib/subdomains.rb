module Subdomains
  class Partner
    class << self
      attr_accessor :subdomains
    end

    def self.subdomains
      return unless load_subdomains?

      @subdomains ||= ::Partner.pluck(:slug)
    end

    def self.load_subdomains?
      ::ActiveRecord::Base.connection.table_exists?("partners")
    end

    def self.matches?(request)
      domain_length = ENV['HOSTNAME'].split('.').count - 1
      subdomains.include?(request.subdomain(domain_length))
    end
  end
end