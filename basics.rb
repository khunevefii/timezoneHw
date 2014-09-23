#Jitranuch Sinthawat 5631220821

require 'sinatra'
require 'timezone'

get '/'  do
	erb :form	
end

post '/city' do
	input_city = params[:message]
	all_timezones = Timezone::Zone.names
	
	begin
	if (input_city.include?" ")
		two_word = input_city.split(' ')
		first_word = two_word[0]
		scd_word = two_word[1]
		city = all_timezones.find{ |e| /#{first_word}_#{scd_word}/ =~ e}
	else  
		city = all_timezones.find{ |e| /#{input_city}/ =~ e}
	end
	
	timezone = Timezone::Zone.new :zone => city
	show_time = timezone.time Time.now
	time = show_time.to_s.split(' ')
	real_time = time[1]
	hours = real_time[0,2].to_i
	morning_hours = real_time[0,2]
	mins = real_time[2..4]

	if hours>12&&hours<=23
		afternoon = (hours-12).to_s + mins
		"The current time in #{input_city} is  #{afternoon} PM"
	else 
		 morning = morning_hours + mins
	 	"The current time in #{input_city} is  #{morning} AM"
	end
	rescue
		"Sorry! We cannot find #{input_city} time."
	end


end

