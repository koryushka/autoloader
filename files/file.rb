
    input = File.open("/home/koryushka/projects/autoload/input.txt")
    output = File.open("/home/koryushka/projects/autoload/output.txt", "a+")
    while buff = input.read(4096)
      output.write(buff)
    end
    input.close()
    output.close()



Dir.foreach("/home/koryushka/projects/autoload/words/") do |src|
	next if src == '.' or src == '..'
  input = File.open("/home/koryushka/projects/autoload/words/#{src}")

    output = File.open("/home/koryushka/projects/autoload/output.txt", "a+")
    while buff = input.read(4096)
      output.write(buff)
    end
    input.close()
    output.close()
  end	