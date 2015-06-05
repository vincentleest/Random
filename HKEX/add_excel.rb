#!/usr/bin/env ruby

require 'rubyXL'


#workbook = RubyXL::Parser.parse '/Users/vincentleest/Downloads/HKEX-HSIOptions-2015-Master.xlsx'

workbook = RubyXL::Workbook.new

workbook.worksheets.each {|s| puts s.sheet_name}


ws = workbook["Sheet2"]

#ws = workbook[0]

ws ||= workbook.add_worksheet "June-1"


#ws.sheet_name = "asdf"


workbook.worksheets.each {|s| puts s.sheet_name}

#ws = workbook[0]

#ws.add_cell(0,0, 'asdf')
#
#workbook.write "./test.xlsx"

