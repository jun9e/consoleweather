require 'open-uri'
require 'json'

def ask_location
	print "Where would you like to travel today?\n"
	answer = gets.chomp.split(',')
	# answer = "paris, berlin, london".split(',')
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
	data[:humidity] = main["humidity"].to_s + "%"
	data
end

def format_table(rows)
	# find way to print results as table
	# puts results
	
	rows.each do |row|
		print_single_row(row)
		puts row.class
		puts "--------------------------------------------------------------------"
	end
end
	
def print_single_row(row)
	print row[:city].ljust(15)
	print row[:description].ljust(15)
	print row[:temperature].to_s.rjust(15)
	print row[:humidity].to_s.rjust(15) + "\n"
end

location = ask_location
results = Array.new

table_header = Hash.new
table_header[:city] = "City"
table_header[:description] = "Weather"
table_header[:temperature] = "Temperatur"
table_header[:humidity] = "Humidity"

results << table_header

location.each do |one_location|
	data = weather_data(one_location)
	results << data
end

format_table(results)

# to do
# splitting weather_data into separated functions
# save api uri in one global variable