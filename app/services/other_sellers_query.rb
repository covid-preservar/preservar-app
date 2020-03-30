# frozen_string_literal: true
class OtherSellersQuery

  def self.for_seller(seller)
    base_scope = Seller.where.not(id: seller.id).includes([:category]).order('RANDOM()').limit(4)
    other_sellers = base_scope.where(area: seller.area)
    local = true

    if other_sellers.none?
      other_sellers = base_scope.where(category: seller.category)
      local = false
    end

    OpenStruct.new(sellers: other_sellers, local: local)
  end
end
