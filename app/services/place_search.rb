class PlaceSearch

  attr_accessor :category, :city, :partner

  def initialize(category: nil, city: nil, partner: nil)
    @category = Category.find(category) if category.present?
    @city = city.presence
    @partner = partner
  end

  def places
    return @places if @places.present?

    base_scope = if category.present?
      category.places
    elsif partner.present? && partner.restricted_categories&.any?
      Place.where(category_id: partner.restricted_category_ids)
    else
      Place
    end
    base_scope = base_scope.includes(:category).published

    @places = city.present? ? base_scope.where(area: city).sorted : base_scope.sorted
  end

  def title
    if category.nil? && city.nil?
      "Todos os locais"
    else
      "#{category&.name_plural || 'Locais'} em #{city.presence || 'todo o país'}"
    end
  end
end