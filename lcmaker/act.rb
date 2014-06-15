array =[]
File.open("/home/koryushka/projects/autoload/lcmaker/test.txt" ).each do |x|
	if x.gsub("\n","") != ""
      string = "#{x.gsub("\n","")}\r"
      string2 = "#{x.gsub("\n","")} оптом\r"   
      string3 = "#{x.gsub("\n","")} продажа\r"     
      string4 = "#{x.gsub("\n","")} цены\r"    
      string5 = "#{x.gsub("\n","")} недорого\r"   
      string6 = "#{x.gsub("\n","")} дешево\r"             

      #string2 = "#{x.gsub("\n","").gsub("характеристики","характеристика")}\r"   
      #string3 = "#{x.gsub("\n","").gsub("купить","куплю")}\r"    
                         
	array << string
      array << string2           
      array << string3
      array << string4     
      array << string5
      array << string6   
          
      array << "\n"
	  end 

end
puts array

File.open("/home/koryushka/projects/autoload/lcmaker/result.txt", 'w' ) do |x|
	array.each do |str|
		x << str
	end
	end
 