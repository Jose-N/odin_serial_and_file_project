puts "EventManager Initialized"

lines = File.readlines "event_attendees.csv"
lines.each_with_index do |line,index|
  next if index == 0
  colums = line.split(",")
  name = colums[2]
  puts name
end
