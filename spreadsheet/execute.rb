#!/usr/local/bin/ruby -w

array = ["10%","15","25","35","20%","4","5","30%","5.5","45%","6","100%","30","40","50"]

array.each_with_index do |a, index|
	if a == "10%"
		@i_10 = index 
		@v_10 = a
	elsif a == "смежные_10"
		@i_10_adjacent = index
		@v_10_adjacent = a
	elsif a == "15%"
		@i_10 = index 
		@v_10 = a
	elsif a == "смежные_15"
		@i_15_adjacent = index
		@v_15_adjacent = a		
	elsif a =="20%" 
		@i_20 = index 
		@v_20 = a
	elsif a == "смежные_20"
		@i_20_adjacent = index
		@v_20_adjacent = a	
	elsif a =="25%" 
		@i_25 = index 
		@v_25 = a
	elsif a == "смежные_25"
		@i_25_adjacent = index
		@v_25_adjacent = a	
	elsif a =="20_19%" 
		@i_20_19 = index 
		@v_20_19 = a
	elsif a == "смежные_20_19"
		@i_20_19_adjacent = index
		@v_20_19_adjacent = a	
	elsif a =="30%"
		@i_30 = index 
		@v_30 = a 
	elsif a == "смежные_30"
		@i_30_adjacent = index
		@v_30_adjacent = a	
	elsif a =="30_30"
		@i_30_30 = index 
		@v_30_30 = a 
	elsif a == "смежные_30_30"
		@i_30_30_adjacent = index
		@v_30_30_adjacent = a	
	elsif a =="45%"
		@i_45 = index 
		@v_45 = a 
	elsif a == "смежные_45"
		@i_25_adjacent = index
		@v_25_adjacent = a	
	elsif a =="45_50"
		@i_45_50 = index 
		@v_45_50 = a 
	elsif a == "смежные_45_50"
		@i_45_50_adjacent = index
		@v_45_50_adjacent = a			
	elsif a =="50%"
		@i_50 = index 
		@v_50 = a 
	elsif a == "смежные_45"
		@i_50_adjacent = index
		@v_50_adjacent = a	
	elsif a =="50_55"
		@i_50_55 = index 
		@v_50_55 = a 
	elsif a == "смежные_50_55"
		@i_50_55_adjacent = index
		@v_50_55_adjacent = a
	elsif a =="75%"
		@i_75 = index 
		@v_75 = a 
	elsif a == "смежные_75"
		@i_75_adjacent = index
		@v_75_adjacent = a	
	elsif a =="70_70"
		@i_70_70 = index 
		@v_70_70 = a 
	elsif a == "смежные_70_70"
		@i_70_70_adjacent = index
		@v_70_70_adjacent = a
	elsif a =="100%"
		@i_100 = index 
		@v_100 = a
	elsif a == "смежные_100"
		@i_100_adjacent = index
		@v_100_adjacent = a	
	elsif a =="90_90"
		@i_90_90 = index 
		@v_90_90 = a 
	elsif a == "смежные_70_70"
		@i_90_90_adjacent = index
		@v_90_90_adjacent = a
	end
end 
@array_of_value = [@v_10, @v_10_adjacent, @v_15, @i_15_adjacent, @v_20, @i_20_adjacent, @v_25, @i_25_adjacent, @v_20_19, @i_20_19_adjacent, @v_30, @i_30_adjacent, @v_30_30, @i_30_30_adjacent, @v_45, @i_45_adjacent, @v_45_50, @i_45_50_adjacent, @v_50, @i_50_adjacent, @v_50_55, @i_50_55_adjacent, @v_75, @i_75_adjacent, @v_70_70, @i_70_70_adjacent, @v_100, @i_100_adjacent, @v_90_90, @i_90_90_adjacent]
@array_of_value = @array_of_value.compact
@array_of_index = [@i_10, @i_10_adjacent, @i_15, @i_15_adjacent, @i_20, @i_20_adjacent, @i_25, @i_25_adjacent, @i_20_19, @i_20_19_adjacent, @i_30, @i_30_adjacent, @i_30_30, @i_30_30_adjacent, @i_45, @i_45_adjacent, @i_45_50, @i_45_50_adjacent, @i_50, @i_50_adjacent, @i_50_55, @i_50_55_adjacent, @i_75, @i_75_adjacent, @i_70_70, @i_70_70_adjacent, @i_100, @i_100_adjacent, @i_90_90, @i_90_90_adjacent]
@array_of_index = @array_of_index.compact
#puts @array_of_index.index(@i_20).next
#puts @array_of_value[@array_of_index.index(@i_20).next]
#puts array.index(@array_of_value[@array_of_index.index(@i_20).next])
if @i_10
	puts "for 10%:"
	puts array.values_at(@i_10.to_i..array.index(@array_of_value[@array_of_index.index(@i_10).next])-1)
end
puts

if @i_20
	puts "for 20%:"
	puts array.values_at(@i_20.to_i..array.index(@array_of_value[@array_of_index.index(@i_20).next])-1)

end
puts
if @i_30
	puts "for 30%:"
	puts array.values_at(@i_30.to_i..array.index(@array_of_value[@array_of_index.index(@i_30).next])-1) 
end
puts
if @i_45
	puts "for 45%:"
	puts array.values_at(@i_45.to_i..array.index(@array_of_value[@array_of_index.index(@i_45).next])-1) 
end
puts
if @i_100
	puts "for 100%:"

	puts array.values_at(@i_100.to_i..array.index(array.last)) 
end
puts


