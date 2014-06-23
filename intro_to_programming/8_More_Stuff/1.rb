 array = ["laboratory", "experiment", "Pans Labyrinth", "elaborate", "polar bear"]

 	array.each do |x|
 	if x =~ /lab/
 		puts "Match Found! #{x}"
 	else 
 		puts "No match"
 	end
end


# using method

def check_in(word) 

	if /lab/ =~ word
		puts word
	else
		puts "No match"
	end
end

check_in("laboratory")
check_in("experiment")
check_in("Pans Labyrinth")
check_in("elaborate")
check_in("polar_bear")


