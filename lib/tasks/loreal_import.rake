task :loreal_import => :environment do
  require 'csv'

  failed = []
  Aws.config[:credentials] = Aws::Credentials.new(ENV['AWS_ACCESS_KEY_ID'], ENV['AWS_SECRET_ACCESS_KEY'])
  s3 = Aws::S3::Resource.new
  bucket = s3.bucket('assets.preserve.pt')
  obj = bucket.object('loreal_partners.csv')
  content = obj.get.body.string

  CSV.parse(content, headers: true).each do |client|

    place = Place.find_by(id: client['id'])
    loreal_id = PartnerIdentifier.find_by(identifier: client['client_id'], partner_id: 1)

    if place.present? && loreal_id.present?
      place.create_partnership!(partner_identifier: loreal_id, approved: true, partner_id: 1)
      loreal_id.mark_used!
    else
      failed << client.to_s
    end
  end

  puts failed
end