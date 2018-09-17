include HomeHelper
class HomeController < ApplicationController
  def index
	
  end

  def search
  	redirect_to get_search_url(params)

  # 	for (var i = 1; i <= rooms; i++) {
  #   $('#room' + i).val('0')
  # }

  # // Adding Adults into each room
  # for (var i = 1; i <= rooms; i++) {
  #   var adults_to_add = parseInt($('#adults_count_room_'+i).val())
  #   $('#room' + i).val(adults_to_add)
  # }

  end

  def terms_of_service
  end

  def privacy_policy
  end

  def about_us
  end
end
