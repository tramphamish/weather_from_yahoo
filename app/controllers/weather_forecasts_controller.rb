class WeatherForecastsController < ApplicationController
  def index

    if params[:city] && params[:state]
      city = params[:city]
      state = params[:state]
    else
      city = "lasvegas"
      state = "nv"
    end
    @forecast = Unirest.get("https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20weather.forecast%20where%20woeid%20in%20(select%20woeid%20from%20geo.places(1)%20where%20text%3D%22#{city}%2C%20#{state}%22)&format=json&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys").body
    @current = @forecast['query']['results']['channel']['item']['condition']['temp']
    @daily_forecast = @forecast['query']['results']['channel']['item']['forecast']
    @city_name = @forecast['query']['results']['channel']['location']['city']
  end
end
