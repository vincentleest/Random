#!/usr/bin/env ruby

#require 'rubyXL'
require 'date'

#workbook = RubyXL::Parser.parse '/Users/vincentleest/Downloads/HKEX-HSIOptions-2015-Master.xlsx'

#workbook = RubyXL::Workbook.new
#
#puts workbook.worksheets.size
#
#ws = workbook[0]
#
#ws.add_cell(0,0, 'asdf')
#
#workbook.write "./test.xlsx"

year =  Date.today.year
puts year
last_day = (Date.new(year, 1)..Date.new(year+1, 1)).select {|d| d.day == 1}.map {|d| d - 1}.drop(1)

puts last_day.nil?
puts last_day.join " "
