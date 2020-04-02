# frozen_string_literal: true
class OtherPlacesQuery

  def self.for_place(place)
    base_scope = Place.published.where.not(id: place.id).includes([:category]).order('RANDOM()').limit(4)
    other_places = base_scope.where(area: place.area)
    local = true

    if other_places.none?
      other_places = base_scope.where(category: place.category)
      local = false
    end

    OpenStruct.new(places: other_places, local: local)
  end
end
