#!/usr/bin/env ruby

puts "working on " + ARGV[0]

fh = File.readlines(ARGV[0] + '.txt')
index_name = fh.first
data = fh.select { |line| line =~ /^(P||C) / }
data.each { |line| 
	line.gsub!(",", "")
	line.gsub!(" ", ",")
	line[1] = " "
	line[8] = " "
	line[10] = " "
} 

put_data, call_data = data.partition { |line| line =~ /^P /}

File.open(ARGV[0] + ".csv", "w") do |file|
	file.write("Contract,Open,Bid,Ask,Last Traded,High,Low,Volume,Prev. DaySettlement Price,Net Change,Prev. Day Open Interest\n")
	file.write call_data.join("")
	file.write put_data.join("")
end

