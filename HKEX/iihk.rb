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

def upload_file(file_name)
	home = ENV['HOME']
	system "#{home}/workspace/Random/HKEX/dropbox_uploader.sh -f '#{home}/.dropbox_uploader' upload '#{home}/workspace/Random/HKEX/#{file_name}' '#{file_name}'"
end

def download_file(file_name)
	home = ENV['HOME']
	system "#{home}/workspace/Random/HKEX/dropbox_uploader.sh -f '#{home}/.dropbox_uploader' download '#{file_name}' '#{home}/workspace/Random/HKEX/#{file_name}'"
end

def get_option_data(name)
	puts "Getting #{name} Option data"
	option_date = Date.today.strftime("%y%m%d")
	option_month = Date.today.strftime("%^b-%y")
    begin    
	uri = URI('http://iihk.org/hkex/index.php')
	res = Net::HTTP.post_form(uri, :option_class=> name, :option_date=> option_date, :option_month => option_month, :submitbutton => URI.unescape("%E6%8C%89%E6%AD%A4%E6%9F%A5%E8%A9%A2"))
	res.body
    rescue Errno::ENETUNREACH
      data = `curl --data 'option_class=#{name}&option_date=150521&option_month=MAY-15&submitbutton=%E6%8C%89%E6%AD%A4%E6%9F%A5%E8%A9%A2' http://iihk.org/hkex/index.php`
    end

    unless res.nil? then res.body else data end
end

def option_xlsx_filename(option)
	"OptionStatus-#{option.upcase}-#{Date.today.year}-#{Date.today.strftime("%^b")}.xlsx"
end

def save_to_workbook(name, data)
	puts "Saving #{name} option data to workbook"
	file_name = option_xlsx_filename(name)
	sheet_name = Date.today.strftime("%m-%d")

	if new_workbook?
		workbook = RubyXL::Workbook.new(file_name)
		ws = workbook[0]
	else
		unless File.exist? file_name
			download_file(file_name)	
		end
		unless File.exist? file_name
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

["hsi", "hhi"].each { |o|
  data = get_option_data(o)
  save_to_workbook(o, data)
  upload_file option_xlsx_filename data
}



