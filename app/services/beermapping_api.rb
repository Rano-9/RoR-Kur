class BeermappingApi

  def self.places_in(city)
    city = city.downcase
    
    Rails.cache.fetch(city, expire_in: 1.week) {get_places_in(city)}

  end

  def self.get_places_in(city)
    url = "https://studies.cs.helsinki.fi/beermapping/locations/"

    response = HTTParty.get "#{url}#{ERB::Util.url_encode(city)}"
    places_from_api = response.parsed_response["bmp_locations"]["location"]

    return [] if places_from_api.is_a?(Hash) && places_from_api['id'].nil?

    places_from_api = [places_from_api] if places_from_api.is_a?(Hash)
    places_from_api.map do | location |
      Place.new(location)
    end
  end
end