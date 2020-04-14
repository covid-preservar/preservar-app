# frozen_string_literal: true
class ShrinePromoteJob < ApplicationJob
  queue_as :default

  # attachment has changed or record has been deleted, nothing to do
  discard_on Shrine::AttachmentChanged, ActiveRecord::RecordNotFound

  def perform(attacher_class, record_class, record_id, name, file_data)
    attacher_class = Object.const_get(attacher_class)
    record = Object.const_get(record_class).unscoped.find(record_id)

    attacher = attacher_class.retrieve(model: record, name: name, file: file_data)
    attacher.create_derivatives if attacher.respond_to?(:create_derivatives)
    attacher.atomic_promote
  end
end
