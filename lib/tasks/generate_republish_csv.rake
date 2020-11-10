task :generate_republish_csv => :environment do
  CSV.open('to_republish.csv', 'wb', col_sep: ';') do |file|

    file << %w(email republish_link)
    Seller.joins(:places).merge(Place.published).each do |seller|
      print '.'
      token = seller.seller_user.signin_tokens.create(expires_at: 2.weeks.from_now).value

      file << [seller.seller_user.email, "https://preserve.pt/seller/account/republish?signin_token=#{token}"]
      seller.places.published.update_all(published: false)
    end
  end
end