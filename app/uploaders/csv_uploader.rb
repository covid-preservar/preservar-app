# frozen_string_literal: true
class CSVUploader < Shrine
  plugin :default_storage, store: :csv_store

  def generate_location(io, record: nil, **_)
    [record&.id || 'cache', io.original_filename].join('/')
  end

  Attacher.promote_block { promote } # promote synchronously
  Attacher.destroy_block { destroy } # destroy synchronously
end
