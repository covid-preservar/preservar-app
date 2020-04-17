desc 'Temporary task to load Super Bock partner IDs'
task :load_partner_ids => :environment do
  Aws.config[:credentials] = Aws::Credentials.new(ENV['AWS_ACCESS_KEY_ID'], ENV['AWS_SECRET_ACCESS_KEY'])
  s3 = Aws::S3::Resource.new
  bucket = s3.bucket('assets.preserve.pt')
  obj = bucket.object('sb1.txt')
  obj.get.body.string.split.each do |id|
    print '.'
    PartnerIdentifier.create!(identifier: id, partner_id: 2)
  end
  obj = bucket.object('sb2.txt')
  obj.get.body.string.split.each do |id|
    print '.'
    PartnerIdentifier.create!(identifier: id, partner_id: 2)
  end
  obj = bucket.object('sb3.txt')
  obj.get.body.string.split.each do |id|
    print '.'
    PartnerIdentifier.create!(identifier: id, partner_id: 2)
  end
  obj = bucket.object('sb4.txt')
  obj.get.body.string.split.each do |id|
    print '.'
    PartnerIdentifier.create!(identifier: id, partner_id: 2)
  end
end
