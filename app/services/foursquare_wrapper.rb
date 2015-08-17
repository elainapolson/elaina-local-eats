class FoursquareWrapper
  require 'open-uri'

  HTTP_ERRORS = [ OpenURI::HTTPError, Timeout::Error]

  def initialize
    @id = ENV['foursquare_id']
    @secret = ENV['foursquare_secret']
    @offset = 0
    @radius = 50
    @venues = []
  end

  def search_by_nearby(query, location)
    while @offset <= 700 
      api_request = "https://api.foursquare.com/v2/venues/explore?client_id=#{@id}&client_secret=#{@secret}&query=#{query}&near=#{location}&radius=900&offset=#{@offset}&limit=50&v=20140806&m=foursquare"
      begin 
        api_response = open(api_request).read
      rescue *HTTP_ERRORS => error
        return "error message"
      end
      
      response = JSON.parse(api_response)
      @venues << parse_response(response)
      break if @offset == 700 && @venues.empty? 
      @offset += 50
      # @radius += 100
    end  
    return @venues.compact.flatten
  end

  def search_by_coordinates(query, coordinates)
    while @offset <= 700 
      api_request = "https://api.foursquare.com/v2/venues/explore?client_id=#{@id}&client_secret=#{@secret}&query=#{query}&radius=900&ll=#{coordinates}&offset=#{@offset}&limit=50&v=20140806&m=foursquare"
      begin 
        api_response = open(api_request).read
      rescue *HTTP_ERRORS => error
        return "error message"
      end
      
      response = JSON.parse(api_response)
      @venues << parse_response(response)
      break if @offset == 700 && @venues.empty? 
      @offset += 50
      # @radius += 100
    end
    return @venues.compact.flatten
  end

  def parse_response(response)
    response['response']['groups'][0]['items'].select {|venue| meets_requirements?(venue)} 
  end

  def has_rating?(venue)
    !!venue['venue']['rating']
  end


  def ratio_is_high_enough?(venue)
    (venue['venue']['stats']['checkinsCount'])/(venue['venue']['stats']['usersCount']).to_f > 2.5
  end

  def user_count_is_high_enough?(venue)
    venue['venue']['stats']['usersCount'] >= 100
  end

  def not_a_supermarket?(venue)
    venue['venue']['categories'][0]['name'] != "Grocery Store" && venue['venue']['categories'][0]['name'] != "Supermarket" && (venue['venue']['rating'] >= 8)
  end

  def has_high_rating?(venue)
    venue['venue']['rating'] >= 8
  end

  def meets_requirements?(venue)
    has_rating?(venue) && user_count_is_high_enough?(venue) && ratio_is_high_enough?(venue) && not_a_supermarket?(venue) && has_high_rating?(venue)
  end

end