#!/usr/bin/env ruby

require 'rubyXL'
require 'nokogiri'
require 'date'
require 'net/http'

def first_monday
	Date.new(Date.today.year, Date.today.month).step(Date.new(Date.today.year, Date.today.month, -1)).find(&:monday?)
end

def new_workbook? 
	Date.today == first_monday
end

def get_option_data(name)
	puts "Getting #{name} Option data"
	option_date = Date.today.strftime("%y%m%d")
	option_month = Date.today.strftime("%^b-%y")

	uri = URI('http://iihk.org/hkex/index.php')
	res = Net::HTTP.post_form(uri, :option_class=> name, :option_date=> option_date, :option_month => option_month, :submitbutton => URI.unescape("%E6%8C%89%E6%AD%A4%E6%9F%A5%E8%A9%A2"))

	res.body
end

def save_to_workbook(name, data)
	puts "Saving #{name} option data to workbook"
	file_name = "OptionStatus-#{name.upcase}-#{Date.today.year}-#{Date.today.strftime("%^b")}.xlsx"
	sheet_name = Date.today.strftime("%m-%d")

	if new_workbook?
		workbook = RubyXL::Workbook.new(file_name)
		ws = workbook[0]
	else
		unless File.exist?(file_name)
			workbook = RubyXL::Workbook.new
			ws = workbook[0]
		else
			workbook = RubyXL::Parser.parse(file_name)
		end
	end

	unless workbook['Sheet 1'].nil?
		ws.sheet_name = sheet_name
	end	

	ws ||= workbook.add_worksheet sheet_name

	doc = Nokogiri::HTML(data)

	doc.xpath('//table//tr').each_with_index do |row, i|
	  row.xpath('td').each_with_index do |cell,j|
	      ws.add_cell(i,j,cell.text.gsub("\n", ' ').gsub('"', '\"').gsub(/(\s){2,}/m, '\1'))
	  end
	end
	workbook.write(file_name)
end

hsi_data = get_option_data(:hsi)
hhi_data = get_option_data(:hhi)

save_to_workbook(:hsi, hsi_data)
save_to_workbook(:hhi, hhi_data)

