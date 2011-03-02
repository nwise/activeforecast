require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "ActiveForecast" do
  it "should initialize with no arguments" do
    ActiveForecast::Forecast.new.should_not be nil
  end

  it "should initialize with one string argument" do
    ActiveForecast::Forecast.new("KCAK").should_not be nil
  end

  it "should get XML forecast data when passed a valid airport code" do
    ActiveForecast::Forecast.new("KCAK").raw_data.content_type.should == 'text/xml'
  end

  it "should throw NoSuchAirportCodeError when initialized with a bad airport code" do
    error = nil
    begin
      ActiveForecast::Forecast.new("ABC")
    rescue ActiveForecastErrors::NoSuchAirportCode => e
      error = e
    end
    error.should be_a ActiveForecastErrors::NoSuchAirportCode
  end

  it "should define a method on the Forecast object for each element in the XML document" do
    begin
      forecast = ActiveForecast::Forecast.new("KCAK")
      parsed_response = forecast.raw_data.parsed_response
      parsed_response['current_observation'].each do |k,v|
        forecast.send(k.to_s)
      end
      result = true
    rescue NoMethodError
      result = false
    end
    result.should be true
  end
end
