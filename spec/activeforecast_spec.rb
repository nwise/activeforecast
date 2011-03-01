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

  it "should get forecast data when passed an airport code" do
    forecast = ActiveForecast::Forecast.new("KCAK")
    forecast.raw_data.should_not be nil
  end

  it "should throw NoSuchAirportCodeError when initialized with a bad airport code" do
    begin
      forecast = ActiveForecast::Forecast.new("ABC")
      false
    rescue Exception => e
      puts e.inspect
      true
    end
  end

  it "should define a method on the Forecast object for each element in the XML document" do
    pending
  end
end
