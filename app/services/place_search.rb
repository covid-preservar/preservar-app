class PlaceSearch

  attr_accessor :category, :city

  def initialize(category:, city:)
    @category = Category.find(category) if category.present?
    @city = city.presence
  end

  def places
    return @places if @places.present?

    base_scope = @category.present? ? @category.places : Place
    base_scope = base_scope.includes(:category).published

    @places = @city.present? ? base_scope.where(area: @city).sorted : base_scope.sorted
  end

  def title
    if @category.nil? && @city.nil?
      @title = "Todos os locais"
    else
      @title = "#{@category&.name_plural || 'Locais'} em #{@city.presence || 'todo o país'}"
    end
  end
end