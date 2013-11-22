class Location < ActiveRecord::Base
  attr_accessible :latitude, :longitude, :name

  #geocoded_by :name
  #after_validation :geocode
end
