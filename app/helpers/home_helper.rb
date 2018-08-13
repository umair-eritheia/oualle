module HomeHelper

	def formatted_destination destination
		splitted_destination = destination.split(', ')
    if splitted_destination[2] == 'United States'
  		country = ISO3166::Country.find_country_by_name(splitted_destination[2])
  		splitted_destination[1] = country.states[splitted_destination[1]].name
  		splitted_destination.join(', ')
    else
      splitted_destination.delete_at(1)
      splitted_destination.join(', ')
    end
	end

	def get_search_url params
    is_expedia_source  = params['destinationString'].split(', ')[2] == "United States" ? true : false
		params['destinationString'] = formatted_destination(params['destinationString'])
		expedia_arrival_date = params['arrivalDate'].to_date.strftime('%m/%d/%Y')
  	expedia_departure_date = params['departureDate'].to_date.strftime('%m/%d/%Y')
    booking_arrival_date = params['arrivalDate'].to_date.strftime('%Y-%m-%d')
    booking_departure_date = params['departureDate'].to_date.strftime('%Y-%m-%d')

    rooms = params['nr_rooms'].to_i
    guests = params['nr_guests'].to_i
    divider = (guests / rooms)
    room_str = ""
    remaining_guests = guests
    rooms.times do |index|
      room_str += "&" if index > 0
      room_str += (index == rooms-1) ? "room#{index+1}=#{remaining_guests}" : "room#{index+1}=#{divider}"
      remaining_guests = remaining_guests - divider
    end

    index = Algolia::Index.new('comencia_srs')
    results = index.search(params['destinationString'] || '')
    @locations = results["hits"]
    if @locations.present?
      geographyId = @locations.first['regionId']
    end


   client = Aws::CloudSearchDomain::Client.new(  endpoint: ENV['AWS_CLOUDSEARCH_ENDPOINT'],access_key_id: ENV['AWS_ACCESS_KEY_ID'], secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'] )
   response = client.search({query: geographyId.to_s, sort: 'type asc', size: 1 })
   cityId = ''    
    if response.hits.found > 0
      response.hits.hit.each do |suggestion|
        cityId = suggestion.fields["regionid"].first
      end
    end
    if is_expedia_source
      "https://tripscrave.comencia.com/search/result?&destinationString=#{params['destinationString']}&geographyId=#{geographyId}&arrivalDate=#{expedia_arrival_date}&departureDate=#{expedia_departure_date}&#{room_str}"
    else
      "https://www.booking.com/searchresults.html?aid=1474871&city=#{cityId}&checkin=#{booking_arrival_date}&checkout=#{booking_departure_date}"
    end
	end
end
