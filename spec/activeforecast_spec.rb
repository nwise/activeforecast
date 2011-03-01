require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "ActiveForecast" do
  it "should initialize with no arguments" do
    forecast = ActiveForecast::Forecast.new
    forecast.should_not be nil
  end

  it "should initialize with one string argument" do
    forecast = ActiveForecast::Forecast.new("KCAK")
    forecast.should_not be nil
  end

  it "should get XML forecast data when passed a valid airport code" do
    forecast = ActiveForecast::Forecast.new("KCAK")
    forecast.raw_data.content_type.should == 'text/xml'
  end

  it "should throw NoSuchAirportCodeError when initialized with a bad airport code" do
    begin
      forecast = ActiveForecast::Forecast.new("ABC")
      false
    rescue ActiveForecastErrors::NoSuchAirportCode
      true
    end
  end

  it "should define a method on the Forecast object for each element in the XML document" do
    begin
      forecast = ActiveForecast::Forecast.new("KCAK")
      parsed_response = forecast.raw_data.parsed_response
      parsed_response['current_observation'].each do |k,v|
        forecast.send(k.to_s)
      end
      true
    rescue NoMethodError
      false
    end
  end
end
