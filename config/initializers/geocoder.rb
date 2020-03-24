# frozen_string_literal: true
Geocoder.configure(
  ip_lookup: :geoip2,
  geoip2: {
    file: ENV['GEOIP_DB_PATH']
  }
)

Geocoder::Configuration.language = 'pt-BR'