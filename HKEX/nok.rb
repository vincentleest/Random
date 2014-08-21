#!/usr/bin/env ruby

require 'nokogiri'
require 'open-uri'

#doc = Nokogiri::HTML(open("http://www.hkex.com.hk/eng/ddp/Contract_Details.asp?PId=2"))

#doc.css('script, link').each { |node| node.remove }
#puts doc.css('body').text.squeeze(" \n")



fh = File.readlines('HSI.txt')

index_name = fh.first

data = fh.select { |line| line =~ /^(P||C) / }
data.each { |line| line.gsub!(" ", ",")} 

put_data, call_data = data.partition { |line| line =~ /^P,/}

#puts (call_data.join("\n"))
#puts (put_data.join("\n"))

File.open("HSI.csv", "w") do |file|

	file.write("Contract,Open,Bid,Ask,Last,Traded,High,Low,Volume,Prev.,Day,Settlement,Price,Net,Change,Prev.,Day,Open,Interest\n")
	file.write call_data.join("\n")
	file.write put_data.join("\n")

end

