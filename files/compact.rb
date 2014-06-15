file = File.open("/home/koryushka/projects/autoload/output.txt")
array = []
file.each {|x| array << x}




puts array.select { |x| array.count(x) > 1 }

result = array.select { |x| array.count(x) > 1 }

result.each do |r|
	File.open("/home/koryushka/projects/autoload/result.txt", "a+") << r
end