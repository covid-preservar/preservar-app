class Location < ApplicationRecord


  def self.find_location(string)
    where(area: string).or(
      where(district: string)
    ).or(
      where("? = ANY(aliases)", string)
    ).first
  end

end
