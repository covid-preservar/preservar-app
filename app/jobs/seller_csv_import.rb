class SellerCSVImport < ApplicationJob

  attr_accessor :bad_vat_lines,
                :not_found_lines,
                :no_key_lines,
                :dup_key_lines,
                :publish_failed_ids,
                :published_ids

  def perform(import_id)
    import = CSVImport.find(import_id)
    return unless import.pending?
    require 'csv'

    @bad_vat_lines = []
    @not_found_lines = []
    @no_key_lines = []
    @dup_key_lines = []
    @publish_failed_ids = []
    @published_ids = []


    import.processing!
    file = import.file_url
    content = Net::HTTP.get(URI.parse file).force_encoding("UTF-8")

    CSV.parse(content, headers: true).each do |line|

      seller = Seller.find_by(id: line['seller_id'])

      if check_line(line, seller)
        seller.payment_api_key = line['api_key']
        seller.save!
        publish_places(seller)
      end
    end

    import.processing_errors[:bad_vat_lines] = bad_vat_lines
    import.processing_errors[:not_found_lines] = not_found_lines
    import.processing_errors[:no_key_lines] = no_key_lines
    import.processing_errors[:dup_key_lines] = dup_key_lines
    import.processing_errors[:publish_failed_ids] = publish_failed_ids
    import.processing_errors[:published_ids] = published_ids

    import.save

    import.processing_errors.present? ? import.errored! : import.done!

    ApplicationMailer.csv_import_notification(import.id).deliver_later
  end

  def check_line(line, seller)
    if seller.nil?
      not_found_lines << line.to_s.chomp
      return false
    elsif line['vat_id_check'].present? ||
       seller.vat_id != line['vat_id2']
      bad_vat_lines << line.to_s.chomp
      return false
    elsif line['api_key'].nil?
      no_key_lines << line.to_s.chomp
      return false
    elsif seller.payment_api_key.present?
      dup_key_lines << line.to_s.chomp
      return false
    else
      return true
    end
  end

  def publish_places(seller)
    seller.places.each do |place|
      if place.can_publish?
        if place.published_at.nil?
          ApplicationMailer.seller_place_published_notification(place.id).deliver_later
        end
        place.update!(published: true, published_at: Time.now)
        published_ids << place.id
      else
        publish_failed_ids << place.id
      end
    end
  end
end