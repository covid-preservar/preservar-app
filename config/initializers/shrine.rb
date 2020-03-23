require 'shrine'

if Rails.env.production?
  require 'shrine/storage/s3'

  s3_options = {
    bucket: ENV['S3_BUCKET'],
    access_key_id: ENV['AWS_ACCESS_KEY_ID'],
    secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
    region: ENV['AWS_DEFAULT_REGION']
  }

  Shrine.storages = {
    cache: Shrine::Storage::S3.new(prefix: 'uploads/cache', **s3_options), # temporary
    store: Shrine::Storage::S3.new(prefix: 'uploads', **s3_options)        # permanent
  }

  Shrine.plugin :url_options, store: { host: ENV['SHRINE_CDN_URL'] }
  Shrine.plugin :url_options, cache: { host: ENV['SHRINE_CDN_URL'] }
  Shrine.plugin :backgrounding
  # makes all uploaders use background jobs
  Shrine::Attacher.promote_block { ShrinePromoteJob.perform_later(self.class.name, record.class.name, record.id, name, file_data) }
  Shrine::Attacher.destroy_block { ShrineDeleteJob.set(wait: 1.minute).perform_later(self.class.name, data) }

elsif Rails.env.test?
  require 'shrine/storage/memory'

  Shrine.storages = {
    cache: Shrine::Storage::Memory.new,
    store: Shrine::Storage::Memory.new,
  }
else
  require 'shrine/storage/file_system'

  Shrine.storages = {
    cache: Shrine::Storage::FileSystem.new('public', prefix: 'uploads/cache'), # temporary
    store: Shrine::Storage::FileSystem.new('public', prefix: 'uploads')        # permanent
  }
end

Shrine.plugin :activerecord
Shrine.plugin :cached_attachment_data
Shrine.plugin :restore_cached_data
Shrine.plugin :determine_mime_type
Shrine.logger = Rails.logger
Shrine.plugin :instrumentation

class Shrine::Attacher
  def promote(*)
    create_derivatives
    super
  end
end
