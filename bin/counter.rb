# coding:UTF-8
require 'fileutils'
array = []
path_to_log_files = Dir.glob("/home/koryushka/projects/autoload/logs/*.txt")
path_to_log_files.each do |x|
	s = File.open(x).read()
	string = s[/Total: \d+/]
	
      final_string = string.gsub("Total: ",'').to_s if string != nil
      puts final_string
      array << final_string.to_i
    
  end
  puts "Total: #{array.inject{|sum,x| sum+x}}"
