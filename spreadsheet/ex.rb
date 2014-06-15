#encoding: UTF-8
require 'iconv'
list_of_files = Dir["/home/koryushka/projects/autoload/spreadsheet/**/задание.txt"]

	array =[]
list_of_files.each do |filename|

file = File.open(filename,"r:windows-1251")
data = File.read file
file.close
data = Iconv.conv('utf-8','windows-1251',  data)
# data.each do |f|

# 	array << f.chomp
# end

puts data = data.split("\n")
puts data
puts data.class
# data.each do |f|

# 	array << f.chomp
# end
end

