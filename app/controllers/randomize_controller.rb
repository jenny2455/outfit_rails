class RandomizeController < ApplicationController
    def randomize
        @clothes = Clothe.all
        
        require 'net/http'
        require 'net/https' 
        require 'json'
        
        require_relative '../.api_key.rb'
        

        # Get user location
        if Rails.env.production?
            @country = request.location.country
            @city = request.location.city
            @latitude = request.location.latitude.to_s
            @longitude = request.location.longitude.to_s
        end

        if Rails.env.development?
            @city = "Paris"
            @latitude = 48.864716.to_s
            @longitude = 2.349014.to_s
        end
        
        @url = "http://api.openweathermap.org/data/2.5/weather?lat="+ @latitude +"&lon="+ @longitude +"&units=imperial&appid=24491211b2517343f794bed6bab3ded8"
        # @url = "http://api.openweathermap.org/data/2.5/weather?lat="+ @latitude +"&lon="+ @longitude +"&units=imperial&appid=#{$api_key}"
        @uri = URI(@url)
        @temperature_response = Net::HTTP.get(@uri)
        @temperature_output = JSON.parse(@temperature_response)
        @temperature = @temperature_output["main"]["feels_like"].to_i.round(0)
        @result = ""
        
        # Check if the closet has items in it.
        if @clothes.where(user_id: current_user).empty?
            @result = "Looks like your closet is empty! Add some items to generate an outfit."
            @top = "N/A"
            @bottom = "N/A"
        else
            if @temperature == ""
                @result = "Couldn't retrieve weather data, here is our recommendation without it."
                @top = @clothes.where(outfit_type: "Top", user_id: current_user).sample.outfit_name
                @bottom = @clothes.where(outfit_type: "Bottom", user_id: current_user).sample.outfit_name
            elsif @temperature <= 60
                @top = @clothes.where(outfit_type: "Top", user_id: current_user, weather: "Cold").or(@clothes.where(outfit_type: "Top", user_id: current_user, weather: "Warm and Cold")).sample.outfit_name
                @bottom = @clothes.where(outfit_type: "Bottom", user_id: current_user, weather: "Cold").or(@clothes.where(outfit_type: "Bottom", user_id: current_user, weather: "Warm and Cold")).sample.outfit_name
            elsif @temperature > 60
                @top = @clothes.where(outfit_type: "Top", user_id: current_user, weather: "Warm").or(@clothes.where(outfit_type: "Top", user_id: current_user, weather: "Warm and Cold")).sample.outfit_name
                @bottom = @clothes.where(outfit_type: "Bottom", user_id: current_user, weather: "Warm").or(@clothes.where(outfit_type: "Bottom", user_id: current_user, weather: "Warm and Cold")).sample.outfit_name
            end
        end
         
    end

end
