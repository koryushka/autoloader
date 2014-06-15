#!/usr/bin/env ruby -w -s
# -*- coding: utf-8 -*-
$LOAD_PATH.unshift "#{File.dirname(__FILE__)}/../lib"

#```ruby
require 'iconv'
require 'axlsx'
p = Axlsx::Package.new
wb = p.workbook
report = Axlsx::Package.new
workbook = report.workbook

array = []
puts "Chose owner: Kirill or Liza(K/L)"
g = gets.chomp
  if g == "K"
  	puts "Choose direction: Antarion, KOKOC, Webprojects(A,K,W or ALL) "
  	d = gets.chomp!
  	if d == "A"
  		list_of_files = Dir["/home/koryushka/projects/autoload/spreadsheet/files/готово/КИРИЛЛ/ANTARION/**/задание.txt"]
  	elsif  d == "K"
  		list_of_files = Dir["/home/koryushka/projects/autoload/spreadsheet/files/готово/КИРИЛЛ/KOKOC/**/задание.txt"]
  	elsif   d == "W"
  		list_of_files = Dir["/home/koryushka/projects/autoload/spreadsheet/files/готово/КИРИЛЛ/WEBPROJECTS/**/задание.txt"]
  	else
  		list_of_files = Dir["/home/koryushka/projects/autoload/spreadsheet/files/готово/КИРИЛЛ/**/задание.txt"]
  	end
  			  			
  elsif g == "L"
  	puts "Choose direction: Antarion, KOKOC, Webprojects(A,K,W or ALL)"
  	d = gets.chomp!
  	if d == "A"
  		list_of_files = Dir["/home/koryushka/projects/autoload/spreadsheet/files/готово/ЛИЗА/ANTARION/**/задание.txt"]
  	elsif  d == "K"
  		list_of_files = Dir["/home/koryushka/projects/autoload/spreadsheet/files/готово/ЛИЗА/KOKOC/**/задание.txt"]
  	elsif   d == "W"
  		list_of_files = Dir["/home/koryushka/projects/autoload/spreadsheet/files/готово/ЛИЗА/WEBPROJECTS/**/задание.txt"]
  	else
  		list_of_files = Dir["/home/koryushka/projects/autoload/spreadsheet/files/готово/ЛИЗА/**/задание.txt"]
  	end
  else
    list_of_files = Dir["/home/koryushka/projects/autoload/spreadsheet/**/задание.txt"]
  end
list_of_files.each do |filename|
file = File.open(filename,'r:windows-1251')
data = File.read file
file.close
data = Iconv.conv('utf-8','windows-1251',  data)
data = data.split("\n")


data.each do |f|
	array << f.chomp
end
end
array = array.compact
array.delete_if(&:empty?)
array.each do |s|
	s.strip!
end

#array = ["a",1,2,"n",4,5,6,"k",8,9,10,"o",15,"r",17,"a",15, "n", 25,"a",1,2,"n",4,5,6,"k",8,9,10,"o",15,"r",17,"a",15, "n", 25]
b = ["10%","смежные_10","15%","смежные_15","20%","смежные_20","25%","смежные_25", "20_19", "смежные_20_19","30%","смежные_30","30_30","смежные_30_30", "45%", "смежные_45","45_50", "смежные_45_50", "50%", "смежные_50","50_55","смежные_50_55","75%","смежные_75","70_70","смежные_70_70", "100%", "смежные_100","90_90","смежные_90_90"]
a_10 = []
a_10_adjacent = []
a_15 = []
a_15_adjacent = []
a_20 = []
a_20_adjacent = []
a_25 = []
a_25_adjacent = []
a_20_19 = []
a_20_19_adjacent = []
a_30 = []
a_30_adjacent = []
a_30_30 = []
a_30_30_adjacent = []
a_45 = []
a_45_adjacent = []
a_45_50 = []
a_45_50_adjacent = []
a_50 = []
a_50_adjacent = []
a_50_55 = []
a_50_55_adjacent = []
a_75 = []
a_75_adjacent = []
a_70_70 = []
a_70_70_adjacent = []
a_100 = []
a_100_adjacent = []
a_90_90 = []
a_90_90_adjacent =[]


result = []
array.chunk { |n| b.include?(n)}.each { |statement, ary|
  result<<[ary]
}


result.each_slice(2).to_a.each do |x|
	x.flatten!
		len = x[1..x.length-1]
	if x[0] == "10%"
		a_10 << len
	elsif x[0] == "смежные_10"
		a_10_adjacent << len
	elsif x[0] == "15%"
	    a_20 << len
	elsif x[0] == "смежные_15"
	    a_20_adjacent << len
	elsif x[0] == "20%"
		  a_20 << len
	elsif x[0] == "смежные_20"
		a_20_adjacent << len
	elsif x[0] == "25%"
	    a_25  << len
	elsif x[0] == "смежные_25"
	    a_25_adjacent << len  

	elsif x[0] == "20_19"
		a_25 << len
	elsif x[0] == "смежные_20_19"
		a_25_adjacent << len
	elsif x[0] == "30%"
	    a_30 << len
	elsif x[0] == "смежные_30"
	    a_30_adjacent << len
	elsif x[0] == "30_30"
		a_30 << len
	elsif x[0] == "смежные_30_30"
		a_30_adjacent << len
	elsif x[0] == "45%"
	    a_45  << len
	elsif x[0] == "смежные_45"
	    a_45_adjacent << len  	

	elsif x[0] == "45_50"
		a_45 << len
	elsif x[0] == "смежные_45_50"
		a_45_adjacent << len
	elsif x[0] == "50%"
	    a_50 << len
	elsif x[0] == "смежные_50"
	    a_50_adjacent << len
	elsif x[0] == "50_55"
		a_50 << len
	elsif x[0] == "смежные_50_55"
		a_50_adjacent << len
	elsif x[0] == "75%"
	    a_75  << len
	elsif x[0] == "смежные_75"
	    a_75_adjacent << len  	

	elsif x[0] == "70_70"
		a_75 << len
	elsif x[0] == "смежные_70_70"
		a_75_adjacent << len
	elsif x[0] == "100%"
	    a_100 << len
	elsif x[0] == "смежные_100"
	    a_100_adjacent << len
	elsif x[0] == "90_90"
		a_100 << len
	elsif x[0] == "смежные_90_90"
		a_100_adjacent << len	    	        	    
	end
end


@final_array = [a_10, a_10_adjacent, a_20, a_20_adjacent, a_25, a_25_adjacent, a_30, a_30_adjacent, a_45, a_45_adjacent, a_50, a_50_adjacent, a_75, a_75_adjacent, a_100, a_100_adjacent]

@final_array.each do |x|
	x.flatten!
end
@maximum = [a_10.count, a_10_adjacent.count, a_20.count, a_20_adjacent.count, a_25.count, a_25_adjacent.count, a_30.count, a_30_adjacent.count, a_45.count, a_45_adjacent.count, a_50.count, a_50_adjacent.count, a_75.count, a_75_adjacent.count, a_100.count, a_100_adjacent.count].max


def fill_in(arr)
	arr << Array.new(@maximum-arr.count)
end

@final_array.each do |x|
	fill_in(x)
end

@final_array.each do |x|
	x.flatten!
end
final_value = [a_10, a_10_adjacent, a_20, a_20_adjacent, a_25, a_25_adjacent, a_30, a_30_adjacent, a_45, a_45_adjacent, a_50, a_50_adjacent, a_75, a_75_adjacent, a_100, a_100_adjacent]







 # final_value =[a,n,k,o,r]
k = 0.9

wb.styles do |s|
	main = s.add_style :bg_color => "5F9EA0", :fg_color => "FF", :sz => 14, :alignment => { :horizontal=> :right }
	main2 = s.add_style :bg_color => "98F5FF", b: true, :alignment => { :horizontal=> :right }	
	count =  s.add_style :bg_color => "8B8878", :fg_color => "00",b: true, :sz => 14, :alignment => { :horizontal=> :center }
	count2 =  s.add_style :bg_color => "CDC8B1", :fg_color => "00",b: true, :sz => 14, :alignment => { :horizontal=> :center }
	intermediate = s.add_style :bg_color => "DCDCDC", :alignment => { :horizontal=> :right }
	intermediate2 = s.add_style :bg_color => "F8F8FF", :alignment => { :horizontal=> :right }
	money = s.add_style :bg_color => "CD1076", :fg_color => "FF",b: true, :alignment => { :horizontal=> :center }
	money2 = s.add_style :bg_color => "FF1493", :fg_color => "FF",b: true, :alignment => { :horizontal=> :center }
	money3 = s.add_style :bg_color => "8B0000", :fg_color => "FF",b: true, :sz => 14, :alignment => { :horizontal=> :center }
	money4 = s.add_style :bg_color => "DC143C", :fg_color => "FF",b: true, :sz => 14, :alignment => { :horizontal=> :center }
wb.add_worksheet(name: "main") do |sheet|

	sheet.add_row ["10%","смежные_10","20%","смежные_20","25%","смежные_25","30%","смежные_30", "45%", "смежные_45","50%", "смежные_50","75%","смежные_75", "100%", "смежные_100", "Количество слов", "Рублей за подгрузку", "Всего без подгрузки", "Жирное ИГОГО","10%","Смежные 10","20%","смежные_20","25%","смежные_25","30%","смежные_30", "45%", "смежные_45","50%", "смежные_50","75%","смежные_75", "100%", "смежные_100"], :style =>[main,main,main,main,main,main,main,main,main,main,main,main,main,main,main,main,count,money,money,money3,intermediate,intermediate,intermediate,intermediate,intermediate,intermediate,intermediate,intermediate,intermediate,intermediate,intermediate,intermediate,intermediate,intermediate,intermediate,intermediate]
 
    sheet.add_row ["=COUNTA(A3:A#{a_10.length+2})","=COUNTA(B3:B#{a_10.length+2})","=COUNTA(C3:C#{a_10.length+2})","=COUNTA(D3:D#{a_10.length+2})","=COUNTA(E3:E#{a_10.length+2})","=COUNTA(F3:F#{a_10.length+2})","=COUNTA(G3:G#{a_10.length+2})","=COUNTA(H3:H#{a_10.length+2})","=COUNTA(I3:I#{a_10.length+2})","=COUNTA(J3:J#{a_10.length+2})","=COUNTA(K3:K#{a_10.length+2})","=COUNTA(L3:L#{a_10.length+2})","=COUNTA(M3:M#{a_10.length+2})","=COUNTA(N3:N#{a_10.length+2})","=COUNTA(O3:O#{a_10.length+2})","=COUNTA(P3:P#{a_10.length+2})", "=SUM(A2:P2)", "=PRODUCT(Q2,#{k})", "=SUM(U2:AJ2)","=SUM(R2,S2)", "=PRODUCT(A2,10,0.3)", "=PRODUCT(B2,10,0.1)", "=PRODUCT(C2,30,0.3)", "=PRODUCT(D2,30,0.1)", "=PRODUCT(E2,39,0.3)", "=PRODUCT(F2,39,0.1)", "=PRODUCT(G2,60,0.3)", "=PRODUCT(H2,60,0.1)", "=PRODUCT(I2,95,0.3)", "=PRODUCT(J2,95,0.1)", "=PRODUCT(K2,105,0.3)", "=PRODUCT(L2,105,0.1)", "=PRODUCT(M2,140,0.3)", "=PRODUCT(N2,140,0.1)", "=PRODUCT(O2,180,0.15)", "=PRODUCT(P2,180,0.05)"], :style =>[main2,main2,main2,main2,main2,main2,main2,main2,main2,main2,main2,main2,main2,main2,main2,main2,count2,money2,money2,money4,intermediate2,intermediate2,intermediate2,intermediate2,intermediate2,intermediate2,intermediate2,intermediate2,intermediate2,intermediate2,intermediate2,intermediate2,intermediate2,intermediate2,intermediate2,intermediate2]


	0.upto(a_10.length-1) do |x|
		str = []
	    final_value.each do |f|
	  	  str << f[x]
	    end
	    sheet.add_row str
	    # print str
	    # puts
	end

end
end

workbook.styles do |s|
	main = s.add_style :bg_color => "5F9EA0", :fg_color => "FF", :sz => 14, :alignment => { :horizontal=> :right }
	main2 = s.add_style :bg_color => "98F5FF", b: true, :alignment => { :horizontal=> :right }	
	count =  s.add_style :bg_color => "8B8878", :fg_color => "00",b: true, :sz => 14, :alignment => { :horizontal=> :center }
	count2 =  s.add_style :bg_color => "CDC8B1", :fg_color => "00",b: true, :sz => 14, :alignment => { :horizontal=> :center }
workbook.add_worksheet(name: "отчет") do |sheet|

	sheet.add_row ["новые 10","смежные 10","новые 30","смежные 30","новые 39","смежные 39","новые 60","смежные 60", "новые 95", "смежные 95","новые 105", "смежные 105","новые 140","смежные 140", "новые 180", "смежные 180", "Количество слов"]
 
    sheet.add_row ["=COUNTA(A3:A#{a_10.length+2})","=COUNTA(B3:B#{a_10.length+2})","=COUNTA(C3:C#{a_10.length+2})","=COUNTA(D3:D#{a_10.length+2})","=COUNTA(E3:E#{a_10.length+2})","=COUNTA(F3:F#{a_10.length+2})","=COUNTA(G3:G#{a_10.length+2})","=COUNTA(H3:H#{a_10.length+2})","=COUNTA(I3:I#{a_10.length+2})","=COUNTA(J3:J#{a_10.length+2})","=COUNTA(K3:K#{a_10.length+2})","=COUNTA(L3:L#{a_10.length+2})","=COUNTA(M3:M#{a_10.length+2})","=COUNTA(N3:N#{a_10.length+2})","=COUNTA(O3:O#{a_10.length+2})","=COUNTA(P3:P#{a_10.length+2})", "=SUM(A2:P2)"]


	0.upto(a_10.length-1) do |x|
		str = []
	    final_value.each do |f|
	  	  str << f[x]
	    end
	    sheet.add_row str
	    # print str
	    # puts
	end

end
end



if g == "K" && d == "ALL"
  p.serialize 'отчеты/КИРИЛЛ/Кирилл_общий.xlsx'
  report.serialize 'отчеты/КИРИЛЛ/Кирилл_общий_отчет.xlsx'
  puts "Created report Кирилл_общий.xlsx"
elsif g == "L" && d == "ALL"
	p.serialize 'отчеты/ЛИЗА/Лиза_общий.xlsx'
	report.serialize 'отчеты/ЛИЗА/Лиза_общий_отчет.xlsx'
	puts "Created report Лиза_общий.xlsx"
elsif g == "K" && d == "A"
	p.serialize 'отчеты/КИРИЛЛ/ANTARION/Кирилл_ANTARION.xlsx'	
	report.serialize 'отчеты/КИРИЛЛ/ANTARION/Кирилл_ANTARION_отчет.xlsx'	
	puts "Created report Кирилл_ANTARION.xlsx"	
elsif g == "K" && d == "K"
	p.serialize 'отчеты/КИРИЛЛ/KOKOC/Кирилл_KOKOC.xlsx'	
	report.serialize 'отчеты/КИРИЛЛ/KOKOC/Кирилл_KOKOC_отчет.xlsx'	
	puts "Created report Кирилл_KOKOC.xlsx"		
elsif g == "K" && d == "W"
	p.serialize 'отчеты/КИРИЛЛ/WEBPROJECTS/Кирилл_WEBPROJECTS.xlsx'	
	report.serialize 'отчеты/КИРИЛЛ/WEBPROJECTS/Кирилл_WEBPROJECTS_отчет.xlsx'
	puts "Created report Кирилл_WEBPROJECTS.xlsx"	
elsif g == "L" && d == "A"
	p.serialize 'отчеты/ЛИЗА/ANTARION/Лиза_ANTARION.xlsx'	
	report.serialize 'отчеты/ЛИЗА/ANTARION/Лиза_ANTARION_отчет.xlsx'	
	puts "Created report Лиза_ANTARION.xlsx"	
elsif g == "L" && d == "K"
	p.serialize 'отчеты/ЛИЗА/KOKOC/Лиза_KOKOC.xlsx'	
	report.serialize 'отчеты/ЛИЗА/KOKOC/Лиза_KOKOC_отчет.xlsx'	
	puts "Created report Лиза_KOKOC.xlsx"		
elsif g == "L" && d == "W"
	p.serialize 'отчеты/ЛИЗА/WEBPROJECTS/Лиза_WEBPROJECTS.xlsx'	
	report.serialize 'отчеты/ЛИЗА/WEBPROJECTS/Лиза_WEBPROJECTS_отчет.xlsx'	
	puts "Created report Лиза_WEBPROJECTS.xlsx"				
else
	p.serialize 'отчеты/What_is_it.xlsx'
	puts "Created report.xlsx"	
end


  	


