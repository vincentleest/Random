#!/usr/bin/env ruby

require 'rubyXL'
require 'nokogiri'
require 'date'
require 'net/http'

def first_monday
	Date.new(Date.today.year, Date.today.month).step(Date.new(Date.today.year, Date.today.month, -1)).find(&:monday?)
end

def till_today
	Date.new(Date.today.year, Date.today.month,1).step(Date.today).reject{|x| [0,6,7].include?(x.wday)}
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
    get_option_data_by_date(name, Date.today)
end

def get_option_data_by_date(name, date)
	puts "Getting #{name} Option data"
	option_date = date.strftime("%y%m%d")
	option_month = date.strftime("%^b-%y")
    begin    
	uri = URI('http://iihk.org/hkex/index.php')
	res = Net::HTTP.post_form(uri, :option_class=> name, :option_date=> option_date, :option_month => option_month, :submitbutton => URI.unescape("%E6%8C%89%E6%AD%A4%E6%9F%A5%E8%A9%A2"))
	res.body
    rescue Errno::ENETUNREACH
      puts "used curl"
      data = `curl --data 'option_class=#{name}&option_date=#{option_date}&option_month=#{option_month}&submitbutton=%E6%8C%89%E6%AD%A4%E6%9F%A5%E8%A9%A2' http://iihk.org/hkex/index.php`
    end

    unless res.nil? then res.body else data end
end

def option_xlsx_filename(option)
	"OptionStatus-#{option.upcase}-#{Date.today.year}-#{Date.today.strftime("%^b")}.xlsx"
end

def save_to_workbook(name, data, date)
	puts "Saving #{name} option data to workbook"
	file_name = option_xlsx_filename(name)
	sheet_name = date.strftime("%m-%d")

	if new_workbook?
    puts "Crateing new workbook"
		workbook = RubyXL::Workbook.new
		ws = workbook["Sheet1"]
		ws.sheet_name = sheet_name
	else
		unless File.exist? file_name
      puts "File #{file_name} doesn't exists"
			download_file(file_name)	
		end
		unless File.exist? file_name
			#Should not need to recreate file in the middle of the month
			workbook = RubyXL::Workbook.new
			ws = workbook["Sheet1"]
			ws.sheet_name = sheet_name
		else
			workbook = RubyXL::Parser.parse(file_name)
		end
	end
  
	ws ||= workbook.add_worksheet sheet_name
	puts "Working on sheet #{ws.sheet_name}"

	#Extract data
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

	lines.reject!{|l| l.empty?}	

	#Write to file
	lines[1..-1].each_with_index do |row, i|
    count = row.split(',').length
    case count
    when 3
		  # header
      ws.merge_cells(i, 0, i, 8)  
      ws.merge_cells(i, 9, i, 11)  
      ws.merge_cells(i, 12, i, 20)  
		  cells = row.split(',')
		  ws.add_cell(i,0,cells[0])
		  ws.add_cell(i,9,cells[1])
		  ws.add_cell(i,12,cells[2])

	  when 15, 21
		  # Summary
		  # Body
		  row.split(',').each_with_index do |cell, j| 
   		  ws.add_cell(i,j,cell)
      end
	  when 16
		  # Footer
      ws.merge_cells(i, 6, i, 9)  
      ws.merge_cells(i, 11, i, 13)  
		  
		  cells = row.split(',')
      cells[0..5].each_with_index do |cell, j|
		    ws.add_cell(i,j,cell)
      end
		  ws.add_cell(i,6,cells[6])
      ws.add_cell(i,10,cells[7])
		  ws.add_cell(i,11,cells[8])
		  ws.add_cell(i,14,cells[8])
      cells[9..15].each_with_index do |cell, j|
		    ws.add_cell(i,j+14,cell)
      end
	  end
	end

	workbook.write(file_name)
end


#till_today.each{ |d|
#  
#  data = get_option_data_by_date( :hsi, d)
#  save_to_workbook(:hsi, data, d)
#
#  data = get_option_data_by_date( :hhi, d)
#  save_to_workbook(:hhi, data, d)
#}
#
#["hsi", "hhi"].each { |o|
#  d = Date.new(2015, 6, 9)
#  data = get_option_data_by_date(o, d)
#  save_to_workbook(o, data, d)
#  upload_file option_xlsx_filename o    
#  File.delete option_xlsx_filename o
#}
#

["hsi", "hhi"].each { |o|
  Date.today.strftime("%y%m%d")
  data = get_option_data o
  save_to_workbook(o, data, Date.today)
  upload_file option_xlsx_filename o    
  File.delete option_xlsx_filename o
}
