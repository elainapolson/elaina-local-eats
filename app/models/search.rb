class Search
  
  def self.request_near(query, near)
    @venues = FoursquareWrapper.new.search_by_nearby(query, near)
    if @venues == "error message"
      return "error message"
    else
      return @venues
    end
  end

  def self.request_ll(query, ll)
    @venues = FoursquareWrapper.new.search_by_coordinates(query, ll)
    if venues == "error message"
      return "error message"
    else
      return @venues
    end
  end

  def self.get_google_locations(venues)
    @google_map_locs = []
    venues.each.with_index(1).map do |venue, i| 
        longitude = venue['venue']['location']['lng']
        latitude = venue['venue']['location']['lat']
        name = venue['venue']['name']
        address = venue['venue']['location']["formattedAddress"]
        rating = venue['venue']['rating']
        @google_map_locs << [name, latitude, longitude, i, address, rating]
    end
    @google_map_locs
    binding.pry
  end
  
end