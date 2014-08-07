array = [1,2,3,4,5,6,7,8,9,10]

new_array = []

array.select do |x|
	if x.odd?
		new_array.push(x)
	end
end

p new_array