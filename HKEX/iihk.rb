#!/usr/bin/env ruby

#curl --data "option_class=hhi&option_date=150520&option_month=MAY-15&submitbutton=%E6%8C%89%E6%AD%A4%E6%9F%A5%E8%A9%A2" http://iihk.org/hkex/index.php 

require 'rubyXL'
require 'nokogiri'

f = File.open(ARGV[0])

doc = Nokogiri::HTML(f)
workbook = RubyXL::Workbook.new
ws = workbook[0]

doc.xpath('//table//tr').each_with_index do |row, i|
  row.xpath('td').each_with_index do |cell,j|
      #print '"', cell.text.gsub("\n", ' ').gsub('"', '\"').gsub(/(\s){2,}/m, '\1'), "\", "
      ws.add_cell(i,j,cell.text.gsub("\n", ' ').gsub('"', '\"').gsub(/(\s){2,}/m, '\1'))
  end
end

f.close

workbook.write("./"+ARGV[0]+".xlsx")





