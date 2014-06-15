content = File.open("/home/koryushka/projects/autoload/task/test.txt").read()
          content.gsub!("\r","\r\n")
          content.each_line do |x|
          	array =  x.partition(" ")
          	puts array[2]
          	File.open("/home/koryushka/projects/autoload/task/test2.txt","a+"){|x| x.print array[2]}

          end