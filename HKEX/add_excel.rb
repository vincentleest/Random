#!/usr/bin/env ruby

require 'rubyXL'
require 'nokogiri'


#workbook = RubyXL::Parser.parse '/Users/vincentleest/Downloads/HKEX-HSIOptions-2015-Master.xlsx'

#workbook = RubyXL::Workbook.new
#
#workbook.worksheets.each {|s| puts s.sheet_name}
#
#
#ws = workbook["Sheet2"]

#ws = workbook[0]

#ws ||= workbook.add_worksheet "June-1"
#
#
##ws.sheet_name = "asdf"
#
#
#workbook.worksheets.each {|s| puts s.sheet_name}
#
#ws = workbook[0]

#ws.add_cell(0,0, 'asdf')
#
#workbook.write "./test.xlsx"

data = File.read "./data.html"




lines = Array.new
doc = Nokogiri::HTML(data)
doc.xpath('//table//tr').each_with_index do |row, i|
	line = ""
    row.xpath('th').each do |cell|
      #tmp ='"', cell.text.gsub("\n", '').gsub('"', '\"').gsub(/(\s){2,}/m, '\1'), "\","
      tmp =cell.text.gsub("\n", '').gsub('"', '\"').gsub(/(\s){2,}/m, '\1'), ","
	  line << tmp.join('')
    end
    row.xpath('td').each do |cell|
      #tmp ='"', cell.text.gsub("\n", '').gsub('"', '\"').gsub(/(\s){2,}/m, '\1'), "\","
      tmp =cell.text.gsub("\n", '').gsub('"', '\"').gsub(/(\s){2,}/m, '\1'), ","
	  line << tmp.join('')
    end
	lines.push line
end


#lines.each { |x| puts x}
lines[-1].split(',').each { |cell| puts cell}

#puts footer values
#doc = Nokogiri::HTML(data)
##doc.xpath('//table//* [self::tr or self::th]').each_with_index do |row, i|
#doc.xpath('//table//tfoot//tr').each_with_index do |row, i|
#  #puts row.text.gsub("\n", ' ').gsub('"', '\"').gsub(/(\s){2,}/m, '\1')
#  row.xpath('th').each_with_index do |cell,j|
#	  puts cell.text
#  end
#end

#    doc.xpath('//table//tfoot//tr').each_with_index do |row, i|
#      row.xpath('th').each_with_index do |cell,j|
#        puts cell.text
#        ws.add_cell(i,j,cell.text.gsub("\n", ' ').gsub('"', '\"').gsub(/(\s){2,}/m, '\1'))
#      end
#    end
