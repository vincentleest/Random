#!/usr/bin/env ruby

#curl --form "option_class=hhi&option_date=150520&option_month=MAY-15&submitbutton=%E6%8C%89%E6%AD%A4%E6%9F%A5%E8%A9%A2" http://iihk.org/hkex/index.php 

require 'nokogiri'

f = File.open("/root/response2.html")
doc = Nokogiri::HTML(f)

doc.xpath('//table//tr').each do |row|
  row.xpath('td').each do |cell|
      print '"', cell.text.gsub("\n", ' ').gsub('"', '\"').gsub(/(\s){2,}/m, '\1'), "\", "
  end
  print "\n"
end

f.close
