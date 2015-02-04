require 'open-uri'
require 'json'

def ask_location
	print 'Where would you like to travel today?'
	gets.chomp.capitalize
end

def weather_data(city)
	file = open("http://api.openweathermap.org/data/2.5/weather?q=" + city)
	contents = file.read
	parsed = JSON.parse(contents)
	weather = parsed["weather"]
	weather[0].fetch('description')
end

def weather_output(x,y)
	"The weather in #{ x } is : #{y}"
end

location = ask_location
city_weather_description = weather_data(location)
puts weather_output(location, city_weather_description)
