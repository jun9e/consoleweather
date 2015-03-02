require 'open-uri'
require 'json'

def ask_location
	print "Where would you like to travel today?\n"
	# answer = gets.chomp.split(',')
	answer = "paris, berlin".split(',')
	answer.map! do |city|
		city.strip.capitalize
	end
	answer
end

def weather_data(city)
	file = open("http://api.openweathermap.org/data/2.5/weather?q=" + city)
	contents = file.read
	parsed = JSON.parse(contents)
	weather = parsed["weather"]
	main = parsed["main"]
	data = Hash.new
	data[:city] = city
	data[:description] = weather[0].fetch('description')
	# Temperature in Kelvin (subtract 273.15 to convert to Celsius)
	data[:temperature] = ((main["temp"] - 273.15).round(1)).to_s + "°C"
	data[:humidity] = main["humidity"]
	data
end

def format_table(results)
	# find way to print results as table
	puts results
end

location = ask_location
results = Array.new

table_header = Hash.new
table_header[:city] = "Stadt"
table_header[:description] = "Wetter"
table_header[:temperature] = "Temperatur"
table_header[:humidity] = "Humidity"

results << table_header

location.each do |one_location|
	data = weather_data(one_location)
	results << data
end

puts format_table(results)