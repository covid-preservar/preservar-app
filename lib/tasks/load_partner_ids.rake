desc 'Temporary task to load LOreal partner IDs'
task :load_partner_ids => :environment do
  Aws.config[:credentials] = Aws::Credentials.new(ENV['AWS_ACCESS_KEY_ID'], ENV['AWS_SECRET_ACCESS_KEY'])
  s3 = Aws::S3::Resource.new
  bucket = s3.bucket('assets.preserve.pt')
  obj = bucket.object('lorealIDs.txt')
  obj.get.body.string.split.each do |id|
    print '.'
    PartnerIdentifier.create!(identifier: id, partner_id: 1)
  end
end
