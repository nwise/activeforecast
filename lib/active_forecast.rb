require 'httparty'
Dir[File.dirname(__FILE__) + '/error/*.rb'].each {|file| require file }

module ActiveForecast

  class Forecast
    attr_accessor :raw_data

    def initialize(airport_code=nil)
      if airport_code
        @raw_data = HTTParty.get("http://www.weather.gov/xml/current_obs/#{airport_code}.xml")
        raise ActiveForecast::Error::NoSuchAirportCode unless @raw_data.content_type == 'text/xml'
      end
    end
  end

end
