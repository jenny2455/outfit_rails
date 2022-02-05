class RandomizeController < ApplicationController
    def randomize
        @clothes = Clothe.all
        
        require 'net/http'
        require 'net/https'
        require 'json'

        # Get user location
        if Rails.env.production?
            @country = request.location.country
            @city = request.location.city
            @latitude = request.location.latitude.to_s
            @longitude = request.location.longitude.to_s
        end

        
        # @url ='http://api.openweathermap.org/data/2.5/weather?zip=77006,us&units=imperial&appid=df0e81cffa9a356fbc90c30af77bb8af'
        # @url = 'http://api.openweathermap.org/geo/1.0/zip?zip=77006,us&appid=df0e81cffa9a356fbc90c30af77bb8af'
        @url = 'http://api.openweathermap.org/data/2.5/weather?lat='+ @latitude +'&lon='+ @longitude +'&units=imperial&appid=df0e81cffa9a356fbc90c30af77bb8af'
        @uri = URI(@url)
        @temperature_response = Net::HTTP.get(@uri)
        @temperature_output = JSON.parse(@temperature_response)
        @temperature = @temperature_output["main"]["feels_like"].to_i.round(0)
        # @city = @temperature_output["name"]
        
        #If statements for weather. 2 scenarios, we can still pick an outfit if the weather doesn't come in.
        # Error handling
        if @temperature == ""
            # set input to "error"
            # select top and bottom with no temp requirements
            @top = @clothes.where(outfit_type: "Top", user_id: current_user).sample.outfit_name
            @bottom = @clothes.where(outfit_type: "Bottom", user_id: current_user).sample.outfit_name
        elsif @temperature <= 60
            # select top and bottom with weather of "cold"
            @top = @clothes.where(outfit_type: "Top", user_id: current_user, weather: "Cold").sample.outfit_name
            @bottom = @clothes.where(outfit_type: "Bottom", user_id: current_user, weather: "Cold").sample.outfit_name
        elsif @temperature > 60
            # select top and bottom with weather of "warm"
            @top = @clothes.where(outfit_type: "Top", user_id: current_user, weather: "Warm").sample.outfit_name
            @bottom = @clothes.where(outfit_type: "Bottom", user_id: current_user, weather: "Warm").sample.outfit_name
        end
         
    end

end
