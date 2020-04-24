task :energia_import => :environment do
  require 'csv'

  Aws.config[:credentials] = Aws::Credentials.new(ENV['AWS_ACCESS_KEY_ID'], ENV['AWS_SECRET_ACCESS_KEY'])
  s3 = Aws::S3::Resource.new
  bucket = s3.bucket('assets.preserve.pt')
  obj = bucket.object('loreal_partners.csv')
  content = obj.get.body.string

  CSV.parse(content, headers: true, col_sep:';').each do |row|
    PartnerIdentifier.create!(partner_id: 3,
                              identifier: row['CPE'],
                              vat_id: row['NIF'])
  end
end
