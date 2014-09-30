#!/usr/bin/env ruby

puts "working on " + ARGV[0]

fh = File.readlines(ARGV[0] + '.txt')
index_name = fh.first
data = fh.select { |line| line =~ /^(P||C) / }
data.each { |line| line.gsub!(" ", ",")} 

put_data, call_data = data.partition { |line| line =~ /^P,/}

File.open(ARGV[0] + ".csv", "w") do |file|

	file.write("Contract,Open,Bid,Ask,Last,Traded,High,Low,Volume,Prev.,Day,Settlement,Price,Net,Change,Prev.,Day,Open,Interest\n")
	file.write call_data.join("\n")
	file.write put_data.join("\n")

end

