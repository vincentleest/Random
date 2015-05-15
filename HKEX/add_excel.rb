#!/usr/bin/env ruby

require 'rubyXL'


#workbook = RubyXL::Parser.parse '/Users/vincentleest/Downloads/HKEX-HSIOptions-2015-Master.xlsx'

workbook = RubyXL::Workbook.new

puts workbook.worksheets.size

ws = workbook[0]

ws.add_cell(0,0, 'asdf')

workbook.write "./test.xlsx"

