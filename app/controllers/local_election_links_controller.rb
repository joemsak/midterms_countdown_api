require 'uri'
require 'net/http'

class LocalElectionLinksController < ApplicationController
  SENATE_ELECTION_BASE_URL = "https://en.wikipedia.org/wiki/United_States_Senate_election_in_"
  HOUSE_ELECTION_BASE_URL = "https://en.wikipedia.org/wiki/United_States_House_of_Representatives_elections,_2018#"

  SENATE_DEFAULT_URL = "https://en.wikipedia.org/wiki/United_States_Senate_elections,_2018#Complete_list_of_races"
  HOUSE_DEFAULT_URL = "https://en.wikipedia.org/wiki/United_States_House_of_Representatives_elections,_2018#Complete_list_of_elections"

  def index
    if (result = Geocoder.search("#{params.fetch(:lat)},#{params.fetch(:lng)}").first) and
         result.data["address"]["countryRegion"] === "United States"

      abbr = result.data["address"]["adminDistrict"]
      state_name = Country["US"].states[abbr]["name"]

      senate_text = "2018 #{state_name} Senate Elections"
      house_text = "2018 #{state_name} House Elections"

      senate_url = "#{SENATE_ELECTION_BASE_URL}#{state_name.gsub(' ', '_')},2018"
      house_url = "#{HOUSE_ELECTION_BASE_URL}#{state_name.gsub(' ', '_')}"

      senate_res = Net::HTTP.get_response(URI(senate_url))
      if senate_res.code === "404"
        senate_url = SENATE_DEFAULT_URL
        senate_text = "2018 U.S. Senate Elections"
      end

      house_res = Net::HTTP.get_response(URI(house_url))
      if house_res.code === "404"
        house_url = HOUSE_DEFAULT_URL
        house_text = "2018 U.S. House Elections"
      end

      render json: {
        senate_text: senate_text,
        senate_url: senate_url,
        house_text: house_text,
        house_url: house_url,
      }
    else
      head 404
    end
  end
end
