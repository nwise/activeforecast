require 'httparty'
Dir[File.dirname(__FILE__) + '/error/*.rb'].each {|file| require file }

module ActiveForecast

  class Forecast
    attr_accessor :raw_data

    def initialize(airport_code=nil)
      if airport_code
        @raw_data = HTTParty.get("http://www.weather.gov/xml/current_obs/#{airport_code}.xml")
        raise ActiveForecastErrors::NoSuchAirportCode unless @raw_data.content_type == 'text/xml'

        @raw_data['current_observation'].each do |k,v|
          ActiveForecast::Forecast.class_eval {define_method(k.to_sym) {v.to_s}}
        end
      end
    end
  end

end
