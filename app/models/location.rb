# frozen_string_literal: true
class Location < ApplicationRecord
  scope :for_district, ->(district) { where(district: district) }

  def self.find_location(string)
    where(area: string).or(
      where(district: string)
    ).or(
      where('? = ANY(aliases)', string)
    ).first
  end

  def self.all_districts
    distinct(:district).pluck(:district).sort
  end

  def self.grouped_areas
    all.group_by(&:district).transform_values { |v| v.map(&:area) }
  end

  def self.grouped_areas_for_areas(areas)
    where(area: areas).group_by(&:district).transform_values { |v| v.map(&:area) }
  end
end
