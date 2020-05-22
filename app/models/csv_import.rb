class CSVImport < ApplicationRecord
  include CSVUploader::Attachment.new(:file)

  enum state: [ :pending, :processing, :errored, :done ]

  belongs_to :admin_user

  validates :file, presence: true

  def bad_vat_lines
    processing_errors['bad_vat_lines']
  end

  def not_found_lines
    processing_errors['not_found_lines']
  end

  def no_key_lines
    processing_errors['no_key_lines']
  end

  def dup_key_lines
    processing_errors['dup_key_lines']
  end

  def publish_failed_ids
    processing_errors['publish_failed_ids']
  end

  def published_places
    Place.where(id: published_place_ids)
  end

  def failed_publish_places
    Place.where(id: publish_failed_ids)
  end

  def bad_vat_lines_count
    bad_vat_lines&.count
  end

  def not_found_lines_count
    not_found_lines&.count
  end

  def no_key_lines_count
    no_key_lines&.count
  end

  def dup_key_lines_count
    dup_key_lines&.count
  end

end
